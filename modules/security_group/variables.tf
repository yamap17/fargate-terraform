variable "name" {}
variable "vpc_id" {}
variable "port" {}
variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "ingress cidr blocks"
}