variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "aws_account_id" {}
variable "alb_log_s3_bucket_name" {
  type        = string
  description = "alb log s3 bucket name"
}
variable "vpc_cidr" {}
variable "subnet_public_a_cidr" {}
variable "subnet_public_c_cidr" {}
variable "subnet_private_a_cidr" {}
variable "subnet_private_c_cidr" {}
variable "access_ingress_cidr" {}
variable "service_tag_name" {}