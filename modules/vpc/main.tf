resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "public" {
  count                  = length(var.public_subnet_cidr_blocks)
  vpc_id                 = aws_vpc.main.id
  cidr_block             = var.public_subnet_cidr_blocks[count.index]
  map_public_ip_on_launch = true
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}
