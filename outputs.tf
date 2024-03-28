
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
