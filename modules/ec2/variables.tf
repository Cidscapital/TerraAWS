variable "subnet_ids" {
  description = "IDs of the subnets to deploy EC2 instances"
}
variable "ami" {
  description = "AMI for the EC2 instances"
  default     = "ami-07d9b9ddc6cd8dd30" // Replace with your actual AMI ID
}
variable "instance_type" {
  description = "Type of EC2 instance"
  default     = "t2.micro"
}
