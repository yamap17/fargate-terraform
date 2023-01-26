variable "aws_region" {
  type        = string
  description = "AWS REGION"
  default     = "ap-northeast-1"
}
variable "backend_bucket_name" {
  type        = string
  description = "tfstate backup bucket name"
  default     = "fargate-terraform-backend-bucket"
}