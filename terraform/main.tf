provider "aws" {
  region = var.region
}

data "aws_vpc" "existing_vpc" {
  id = var.vpc_id
}

data "aws_subnet" "existing_subnet" {
  id = var.subnet_id
}

# Add a random string resource to create a unique suffix for the security group name
resource "random_string" "sg_suffix" {
  length  = 8
  special = false
  upper   = false
  number  = false
}

resource "aws_security_group" "web_sg" {
  # Use the unique suffix from the random_string resource for the security group name
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

  # Update the tag to use the new security group name
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
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo usermod -aG docker ${self.connection.user}", # Use variable for username
      "sudo docker pull ghcr.io/eziodevio/ghcr-democicdapp:9ae7c09f4fe9dbe94c169da2ee69f2f784416c2d",
      "sudo docker run -d -p 80:80 ghcr.io/eziodevio/ghcr-democicdapp:9ae7c09f4fe9dbe94c169da2ee69f2f784416c2d"
    ]
  }
}

