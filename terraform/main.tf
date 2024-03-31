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

locals {
  private_key = jsondecode(data.aws_secretsmanager_secret_version.cicd_private_key_version.secret_string)["privateKey"]
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

resource "aws_iam_role" "ec2_secrets_manager_role" {
  name = "EC2SecretsManagerRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect = "Allow"
        Sid = ""
      },
    ]
  })
}

resource "aws_iam_policy" "secrets_manager_policy" {
  name        = "SecretsManagerAccess"
  description = "IAM policy to access Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "secretsmanager:GetSecretValue"
        Resource = data.aws_secretsmanager_secret.cicd_private_key.arn
        Effect = "Allow"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.ec2_secrets_manager_role.name
  policy_arn = aws_iam_policy.secrets_manager_policy.arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "EC2InstanceProfileForSecretsManager"
  role = aws_iam_role.ec2_secrets_manager_role.name
}

resource "aws_instance" "web_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.existing_subnet.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name

  user_data = <<-EOF
#!/bin/bash
# Install Docker and pull/run the image
sudo dnf install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

# Lowercase the repository owner and pull the image
REPO_NAME=$(echo "${var.repo_owner}" | awk '{print tolower($0)}')
IMAGE_TAG=${var.docker_image_tag}
echo "Pulling image: ghcr.io/${REPO_NAME}/cicd-demoapp:${IMAGE_TAG}"
sudo docker pull ghcr.io/${REPO_NAME}/cicd-demoapp:${IMAGE_TAG} || exit 1

echo "Running container..."
sudo docker run -d --name web_container -p 80:80 ghcr.io/${REPO_NAME}/cicd-demoapp:${IMAGE_TAG} || exit 1
EOF




  tags = {
    Name = "CICD-Web-Instance"
  }
}
