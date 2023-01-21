terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      version = "~> 4.51.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_vpc" "imported" {
  cidr_block = var.aws_vpc_cidr

  tags = {
    "Name" = var.aws_tag_name
  }
  tags_all = {
    "Name" = var.aws_tag_name
  }
}