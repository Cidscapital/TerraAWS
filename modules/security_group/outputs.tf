output "vpc_vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}
