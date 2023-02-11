variable "service_name" {}
variable "family_name" {}
variable "cpu" {
  default = "256"
}
variable "memory" {
  default = "512"
}
variable "vpc_id" {}
variable "vpc_cidr_block" {}
variable "target_group_arn" {}
variable "container_port" {}
variable "desired_count" {
  default = "2"
}
variable "private_subnets" {}
variable "platform_version" {
  default = "1.4.0"
}
