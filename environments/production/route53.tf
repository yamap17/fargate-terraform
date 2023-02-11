# module "route53" {
#   source        = "../../modules/route53"
#   hostzone_name = var.hostzone_name
# }

# module "acm" {
#   source            = "../../modules/acm"
#   record_name       = "*.example.com"
#   alternative_names = []
# }