variable "subnet_ids" {
  description = "IDs of the subnets to deploy EC2 instances"
}

variable "ami" {
  description = "AMI for the EC2 instances"
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  default     = "t2.micro"
}
