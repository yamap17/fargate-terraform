variable "aws_region" {
  type        = string
  description = "AWS REGION"
  default     = "ap-northeast-1"
}
variable "aws_account_id" {
  type        = string
  description = "aws account id"
}
variable "force_destroy" {
  type        = bool
  description = "s3 force destroy flug"
  default     = true
}
variable "lifecycle_enabled" {
  type        = bool
  description = "lifecycle rule enabled flug"
  default     = true
}
variable "lifecycle_expiration_days" {
  type        = number
  description = "lifecycle rule expiration days"
  default     = 180
}
variable "alb_log_s3_bucket_name" {
  type        = string
  description = "alb log bucket name"
  default     = "fargate-terraform-alb-log-bucket"
}
variable "vpc_cidr" {}
variable "subnet_public_a_cidr" {}
variable "subnet_public_c_cidr" {}
variable "subnet_private_a_cidr" {}
variable "subnet_private_c_cidr" {}
variable "access_ingress_cidr" {}
variable "service_tag_name" {}
variable "hostzone_name" {}
variable "alb_name" {}
variable "target_group_name" {}
variable "healthcheck_path" {}
