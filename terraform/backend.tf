
terraform {
  backend "s3" {
    bucket         = "webstaticstatefile"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "statefile-lock-table"
  }
}
