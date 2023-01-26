variable "bucket_name" {
  type        = string
  description = "public bucket name"
}
variable "force_destroy" {
  type        = bool
  description = "s3 force destroy flug"
}