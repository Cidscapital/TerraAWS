variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "192.168.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for the public subnets"
  default     = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24", "192.168.4.0/24"]
}
