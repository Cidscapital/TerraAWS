variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
}

variable "availability_zones" {
  description = "A list of availability zones to distribute subnets"
}

variable "vpc_id" {
  description = "The ID of the VPC to associate the security group with"
}