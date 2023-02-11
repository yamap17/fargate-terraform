########
# VPC
########

module "vpc" {
  source           = "../../modules/vpc"
  vpc_cidr         = var.vpc_cidr
  service_tag_name = var.service_name
}

## Public Network

resource "aws_subnet" "public_a" {
  vpc_id                  = module.vpc.id
  cidr_block              = var.subnet_public_a_cidr
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1a"
}

resource "aws_subnet" "public_c" {
  vpc_id                  = module.vpc.id
  cidr_block              = var.subnet_public_c_cidr
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1c"
}

resource "aws_internet_gateway" "main" {
  vpc_id = module.vpc.id
}

resource "aws_route_table" "public" {
  vpc_id = module.vpc.id
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.main.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public.id
}

## Private Network

resource "aws_subnet" "private_a" {
  vpc_id                  = module.vpc.id
  cidr_block              = var.subnet_private_a_cidr
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false
}

resource "aws_subnet" "private_c" {
  vpc_id                  = module.vpc.id
  cidr_block              = var.subnet_private_c_cidr
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false
}

resource "aws_route_table" "private_a" {
  vpc_id = module.vpc.id
}

resource "aws_route_table" "private_c" {
  vpc_id = module.vpc.id
}

resource "aws_route" "private_a" {
  route_table_id         = aws_route_table.private_a.id
  nat_gateway_id         = aws_nat_gateway.main_a.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private_c" {
  route_table_id         = aws_route_table.private_c.id
  nat_gateway_id         = aws_nat_gateway.main_c.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_a.id
}

resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.private_c.id
}

resource "aws_eip" "nat_gateway_a" {
  vpc        = true
  depends_on = [aws_internet_gateway.main]
}

resource "aws_eip" "nat_gateway_c" {
  vpc        = true
  depends_on = [aws_internet_gateway.main]
}

resource "aws_nat_gateway" "main_a" {
  allocation_id = aws_eip.nat_gateway_a.id
  subnet_id     = aws_subnet.public_a.id
  depends_on    = [aws_internet_gateway.main]
}

resource "aws_nat_gateway" "main_c" {
  allocation_id = aws_eip.nat_gateway_c.id
  subnet_id     = aws_subnet.public_c.id
  depends_on    = [aws_internet_gateway.main]
}