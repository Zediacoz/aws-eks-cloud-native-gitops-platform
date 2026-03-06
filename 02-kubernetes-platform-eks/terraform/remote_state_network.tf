data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "master-devops-tf-state-13370"
    key    = "networking/vpc/terraform.tfstate"
    region = "eu-west-2"
  }
}