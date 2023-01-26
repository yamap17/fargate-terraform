terraform {
  backend "s3" {
    bucket  = "backend-fargate-terraform-bucket"
    key     = "terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}