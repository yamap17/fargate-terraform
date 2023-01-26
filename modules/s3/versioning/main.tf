module "s3_bucket" {
  source        = "../bucket"
  bucket_name   = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_acl" "main" {
  bucket = module.s3_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_main" {
  bucket = module.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}