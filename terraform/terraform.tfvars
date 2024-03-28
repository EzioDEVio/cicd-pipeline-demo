
# terraform.tfvars

region           = "us-east-1"
vpc_id           = "vpc-02039cbbd71d33e59"    # Replace with your VPC ID
subnet_id        = "subnet-0dbae5309497667e1" # Replace with your Subnet ID
ami_id           = "ami-0f403e3180720dd7e"    # Replace with your AMI ID
instance_type    = "t2.micro"
key_name         = "CICDKey"
private_key_path = "C:/Users/moham/OneDrive/Documents/CICDKey.pem"
public_key_path  = "C:/Users/moham/OneDrive/Documents/CICDKey.pub"

# Docker registry credentials
docker_username = "eziodevio"
docker_password = "GITHUB TOKEN"
