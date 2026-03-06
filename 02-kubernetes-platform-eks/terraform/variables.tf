variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "cluster_name" {
  type    = string
  default = "DevOpsEKS"
}


variable "tags" {
  type = map(string)
  default = {
    Owner = "Master"
    Env   = "dev"
  }
}