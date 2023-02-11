output "arn" {
  value = aws_ecs_task_definition.main.arn
}

output "security_group_ids" {
  value = [module.container_sg.security_group_id]
}