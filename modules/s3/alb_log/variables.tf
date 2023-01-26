variable "aws_account_id" {
  type        = string
  description = "aws account id"
}
variable "bucket_name" {
  type        = string
  description = "s3 versioning bucket name"
}
variable "force_destroy" {
  type        = bool
  description = "s3 force destroy flug"
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