module "s3_bucket" {
  source                    = "../bucket"
  bucket_name               = var.bucket_name
  force_destroy             = var.force_destroy
}

resource "aws_s3_bucket_public_access_block" "private" {
  bucket                  = module.s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "main" {
  bucket = aws_s3_bucket.main.bucket

  rule {
    id = "alb_log"
    expiration {
      days = var.lifecycle_expiration_days
    }
    status = var.lifecycle_enabled ? "Enabled" : "Disabled"
  }
}

resource "aws_s3_bucket_policy" "alb_log" {
  bucket = module.s3_bucket.id
  policy = data.aws_iam_policy_document.alb_log.json
}

data "aws_iam_policy_document" "alb_log" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${module.s3_bucket.id}/*"]
    principals {
      type = "AWS"

      identifiers = [var.aws_account_id]
    }
  }
}