variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "ap-southeast-1"
}
variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-0d729a60"
    ap-southeast-1 = "ami-01f7527546b557442"
  }
}

variable "TAG" {
  default = "siddesh-temp"
}

variable "AWS_SUBNET" {}