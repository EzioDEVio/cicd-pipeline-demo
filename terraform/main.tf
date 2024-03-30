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
  name = "democicdprivatekey"
}

data "aws_secretsmanager_secret_version" "cicd_private_key_version" {
  secret_id = data.aws_secretsmanager_secret.cicd_private_key.id
}

locals {
  private_key = jsondecode(data.aws_secretsmanager_secret_version.cicd_private_key_version.secret_string)["privateKey"]
}

# AWS Security Group and AWS Instance Resources...
# The rest of your resources as already defined

resource "null_resource" "docker_image_update" {
  triggers = {
    image_tag = var.docker_image_tag
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = local.private_key
    host        = aws_instance.web_instance.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo Pulling new image with tag: ${var.docker_image_tag}",
      "sudo docker pull ghcr.io/eziodevio/ghcr-democicdapp:${var.docker_image_tag}",
      "sudo docker stop web_container || true",
      "sudo docker rm web_container || true",
      "sudo docker run -d --name web_container -p 80:80 ghcr.io/eziodevio/ghcr-democicdapp:${var.docker_image_tag}"
    ]
  }

  depends_on = [aws_instance.web_instance]
}
