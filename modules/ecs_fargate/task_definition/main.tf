resource "aws_ecs_task_definition" "main" {
  family                   = var.family_name
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("${path.module}/container_definitions.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

module "container_sg" {
  source              = "../../security_group"
  name                = "${var.family_name}-sg"
  vpc_id              = var.vpc_id
  port                = var.container_port
  ingress_cidr_blocks = var.access_ingress_cidr
}

module "ecs_task_execution_role" {
  source     = "../../iam_role"
  name       = "ecs-task-execution"
  identifier = "ecs-tasks.amazonaws.com"
  policy     = data.aws_iam_policy_document.ecs_task_execution.json
}

data "aws_iam_policy_document" "ecs_task_execution" {
  source_policy_documents = [data.aws_iam_policy.ecs_task_execution_role_policy.policy]
  statement {
    effect    = "Allow"
    actions   = ["ssm:GetParameters", "kms:Decrypt"]
    resources = ["*"]
  }
}

data "aws_iam_policy" "ecs_task_execution_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}