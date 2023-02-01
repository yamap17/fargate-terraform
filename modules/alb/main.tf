resource "aws_lb" "alb" {
  name = var.alb_name
  load_balancer_type = "application"
  internal = false
  idle_timeout = 60
  enable_deletion_protection = true
  subnets = var.subnet_public_ids
  access_logs {
    bucket  = var.alb_log_bucket_id
    enabled = true
  }
  security_groups = var.security_group_ids
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = var.alb_arn
  port              = var.port
  protocol          = "HTTP"
  default_action { 
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "これは『HTTP』です"
      status_code  = "200"
    }
  }
}

