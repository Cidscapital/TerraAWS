variable "cidr_block" {
  type = string
  default = "192.168.0.0/16"
}

variable "availability_zones" {
  type = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support = true

  tags = {
    Name = "VPC for Web App"
  }
}

resource "aws_subnet" "public" {
  count = length(var.availability_zones)

  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  vpc_id     = aws_vpc.main.id
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = format("Public Subnet %d", count.index + 1)
  }
}

output "public_subnet_ids" {
  value = aws_subnet.public.*.id
  description = "List of public subnet IDs"
}
