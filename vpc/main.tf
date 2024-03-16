resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "public" {
  count             = 4
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  map_public_ip_on_launch = true
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}
