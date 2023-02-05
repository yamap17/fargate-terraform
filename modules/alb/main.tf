resource "aws_lb" "alb" {
  name                       = var.alb_name
  load_balancer_type         = "application"
  internal                   = false
  idle_timeout               = 60
  enable_deletion_protection = false
  subnets                    = var.subnet_public_ids
  access_logs {
    bucket  = var.alb_log_bucket_id
    enabled = true
  }
  security_groups = var.security_group_ids
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
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

# resource "aws_lb_listener" "https" {
#   load_balancer_arn = aws_lb.alb.arn
#   port              = 443
#   protocol          = "HTTPS"
#   certificate_arn   = var.certificate_arn
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   default_action { 
#     type = "fixed-response"
#     fixed_response {
#       content_type = "text/plain"
#       message_body = "これは『HTTPS』です"
#       status_code  = "200"
#     }
#   }
# }

# resource "aws_lb_listener" "redirect_http_to_https" {
#   load_balancer_arn = aws_lb.alb.arn
#   port              = 8080
#   protocol          = "HTTP"
#   default_action { 
#     type = "redirect"
#     redirect {
#       port         = 443
#       protocol     = "HTTPS"
#       status_code  = "HTTP_301"
#     }
#   }
# }

resource "aws_lb_target_group" "main" {
  name                 = var.target_group_name
  target_type          = "ip"
  vpc_id               = var.vpc_id
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 300

  health_check {
    path                = var.healthcheck_path
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = 200
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  depends_on = [aws_lb.alb]
}

resource "aws_lb_listener_rule" "main" {
  # listener_arn = aws_lb_listener.https.arn
  listener_arn = aws_lb_listener.http.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}