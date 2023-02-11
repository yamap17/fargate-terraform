module "fargate" {
  source           = "../../modules/ecs_fargate"
  service_name     = var.service_name
  family_name      = var.service_name
  cpu              = "256"
  memory           = "512"
  vpc_id           = module.vpc.id
  vpc_cidr_block   = module.vpc.cidr_block
  target_group_arn = module.aws_alb.target_group_arn
  container_port   = 80
  desired_count    = 2
  private_subnets  = [aws_subnet.private_a.id, aws_subnet.private_c.id]
  platform_version = "1.4.0"
}