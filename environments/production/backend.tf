terraform {
  backend "s3" {
    bucket  = "fargate-terraform-backend-bucket"
    key     = "terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}