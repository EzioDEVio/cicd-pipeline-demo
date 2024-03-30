
output "vpc_id" {
  value = data.aws_vpc.existing_vpc.id
}

output "subnet_id" {
  value = data.aws_subnet.existing_subnet.id
}


output "web_instance_public_ip" {
  value = aws_instance.web_instance.public_ip
}

output "web_security_group_id" {
  value = aws_security_group.web_sg.id
}

output "private_key_sample" {
  value     = substr(data.aws_secretsmanager_secret_version.cicd_private_key_version.secret_string, 0, 30)
  sensitive = true
}
