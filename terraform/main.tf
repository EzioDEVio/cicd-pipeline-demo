provider "aws" {
  region = var.region
}

# using existng vpc
data "aws_vpc" "existing_vpc" {   
  id = var.vpc_id
}

# using existng subnet
data "aws_subnet" "existing_subnet" {
  id = var.subnet_id
}

# It is very importan to use AWS secret manager to store secrets and sensetives for optimal security settings. 
# we will etrieve the private key from AWS Secrets Manager using the variable

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
  key_name               = var.key_name               ### I created a key pair in aws console and named it CICDdemoKey
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "CICD-Web-Instance"
  }
#here we refrence the private key from AWS secret manager 
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = data.aws_secretsmanager_secret_version.cicd_private_key_version.secret_string  
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y docker",                     ## here we are deploying docker image(built and pushed to GHCR) 
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo usermod -aG docker ec2-user",
      "sudo docker pull ghcr.io/eziodevio/ghcr-democicdapp:v.1.1.1",
      "sudo docker run -d -p 80:80 ghcr.io/eziodevio/ghcr-democicdapp:v.1.1.1"             #the name of docker image we are deploying...
    ]
  }
}
