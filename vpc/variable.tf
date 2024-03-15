variable "region" {
  description = "The AWS region"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
}

variable "availability_zones" {
  description = "A list of availability zones to distribute subnets"
}
