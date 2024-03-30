provider "aws" {
  region = var.region
}

data "aws_vpc" "existing_vpc" {
  id = var.vpc_id
}

data "aws_subnet" "existing_subnet" {
  id = var.subnet_id
}

data "aws_secretsmanager_secret" "cicd_private_key" {
  name = var.secret_name
}

data "aws_secretsmanager_secret_version" "cicd_private_key_version" {
  secret_id = data.aws_secretsmanager_secret.cicd_private_key.id
}

resource "random_string" "sg_suffix" {
  length  = 8
  special = false
  upper   = false
  numeric = false
}

resource "aws_security_group" "web_sg" {
  name        = "democicd-server-sg-${random_string.sg_suffix.result}"
  description = "Allow web and SSH traffic"
  vpc_id      = data.aws_vpc.existing_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "democicd-server-sg-${random_string.sg_suffix.result}"
  }
}

resource "aws_instance" "web_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.existing_subnet.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "CICD-Web-Instance"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = data.aws_secretsmanager_secret_version.cicd_private_key_version.secret_string
    host        = self.public_ip
  }
}

resource "null_resource" "docker_image_update" {
  triggers = {
    image_tag = var.docker_image_tag
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = data.aws_secretsmanager_secret_version.cicd_private_key_version.secret_string
      host        = aws_instance.web_instance.public_ip
    }

    inline = [
      "sudo docker pull ghcr.io/eziodevio/ghcr-democicdapp:${var.docker_image_tag}",
      "sudo docker stop web_container || true",
      "sudo docker rm web_container || true",
      "sudo docker run -d --name web_container -p 80:80 ghcr.io/eziodevio/ghcr-democicdapp:${var.docker_image_tag}"
    ]
  }

  depends_on = [
    aws_instance.web_instance
  ]
}
