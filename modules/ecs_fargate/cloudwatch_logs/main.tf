resource "aws_cloudwatch_log_group" "for_ecs" {
  name              = var.log_group_name
  retention_in_days = 180
}