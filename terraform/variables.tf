
variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "The ID of the existing VPC"
  type        = string
  default     = "vpc-02039cbbd71d33e59" // Use the actual ID of your existing VPC
}

variable "subnet_id" {
  description = "The ID of the existing subnet"
  type        = string
  default     = "subnet-0dbae5309497667e1" // Use the actual ID of your existing subnet
}


variable "key_name" {
  description = "The name of the existing key pair"
  type        = string
  default     = "CICDKey"
}

variable "secret_name" {
  description = "name of the secret"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0c101f26f147fa7fd"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "docker_username" {
  description = "Docker username for GHCR"
  type        = string
}

variable "docker_password" {
  description = "Docker password or token for GHCR"
  type        = string
}

variable "docker_image_tag" {
  description = "The tag of the Docker image to deploy"
  type        = string

}






