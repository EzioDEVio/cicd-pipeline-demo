
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0" # Specify the version you are using
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0" # Specify the version you are using
    }
  }
}
