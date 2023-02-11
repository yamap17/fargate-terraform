resource "aws_ecs_cluster" "main" {
  name = var.service_name
}

module "task_definition" {
  source              = "./task_definition"
  family_name         = var.family_name
  cpu                 = var.cpu
  memory              = var.memory
  vpc_id              = var.vpc_id
  access_ingress_cidr = [var.vpc_cidr_block]
  container_port      = var.container_port
}

resource "aws_ecs_service" "main" {
  name                              = var.service_name
  cluster                           = aws_ecs_cluster.main.arn
  task_definition                   = module.task_definition.arn
  desired_count                     = var.desired_count
  launch_type                       = "FARGATE"
  platform_version                  = var.platform_version
  health_check_grace_period_seconds = 60
  network_configuration {
    assign_public_ip = false
    security_groups  = module.task_definition.security_group_ids
    subnets          = var.private_subnets
  }
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.family_name
    container_port   = var.container_port
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}