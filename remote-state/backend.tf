terraform {
  backend "s3" {
    bucket = "siddesh-tf-state"
    key = "terraform/state"
    region = "ap-southeast-1"
  }
}