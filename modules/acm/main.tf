resource "aws_acm_certificate" "main" {
  domain_name               = var.record_name
  subject_alternative_names = var.alternative_names
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "sub" {
  name    = var.record_name
  type    = var.record_type
  records = var.record_values
  zone_id = var.route53_zone_id
}

resource "aws_acm_certificate_validaton" "main" {
  certificate_arn = aws_acm_certificate.main.arn
  validation_record_fqdns = [aws_route53_record.sub.fqdn]
}