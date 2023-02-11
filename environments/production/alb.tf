module "s3_alb_log" {
  source                    = "../../modules/s3/alb_log"
  bucket_name               = var.alb_log_s3_bucket_name
  aws_account_id            = var.aws_account_id
  force_destroy             = var.force_destroy
  lifecycle_enabled         = var.lifecycle_enabled
  lifecycle_expiration_days = var.lifecycle_expiration_days
}

module "http_sg" {
  source              = "../../modules/security_group"
  name                = "http-sg"
  vpc_id              = module.vpc.id
  port                = 80
  ingress_cidr_blocks = var.access_ingress_cidr
}

module "https_sg" {
  source              = "../../modules/security_group"
  name                = "https-sg"
  vpc_id              = module.vpc.id
  port                = 443
  ingress_cidr_blocks = var.access_ingress_cidr
}

module "http_redirect_sg" {
  source              = "../../modules/security_group"
  name                = "http-redirect-sg"
  vpc_id              = module.vpc.id
  port                = 8080
  ingress_cidr_blocks = var.access_ingress_cidr
}

module "aws_alb" {
  source             = "../../modules/alb"
  alb_name           = var.alb_name
  subnet_public_ids  = [aws_subnet.public_a.id, aws_subnet.public_c.id]
  security_group_ids = [module.http_sg.security_group_id, module.https_sg.security_group_id, module.http_redirect_sg.security_group_id]
  alb_log_bucket_id  = module.s3_alb_log.s3_bucket_id
  target_group_name  = var.target_group_name
  vpc_id             = module.vpc.id
  healthcheck_path   = var.healthcheck_path
}