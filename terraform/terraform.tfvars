
# terraform.tfvars
region           = "us-east-1"
vpc_id           = "vpc-02039cbbd71d33e59"    # Replace with your VPC ID
subnet_id        = "subnet-0dbae5309497667e1" # Replace with your Subnet ID
ami_id           = "ami-0c101f26f147fa7fd"    # Replace with your AMI ID
instance_type    = "t2.micro"
key_name         = "CICDKey"
secret_name = "democicdprivatekey"
# Docker registry credentials
docker_username = "eziodevio"
docker_password = "GITHUB TOKEN"

