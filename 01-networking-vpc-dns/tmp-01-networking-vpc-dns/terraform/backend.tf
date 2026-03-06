terraform {
  backend "s3" {
    bucket         = "master-devops-tf-state-13370"
    key            = "networking/vpc/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "tf-state-lock"
    encrypt        = true
  }
}