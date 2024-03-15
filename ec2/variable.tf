variable "region" {
  description = "The AWS region"
}

variable "ami" {
  description = "The AMI ID for the EC2 instances"
}

variable "instance_type" {
  description = "The type of EC2 instances"
}

variable "ec2_count" {
  description = "The number of EC2 instances to create"
}

variable "public_key_path" {
  description = "The path to the public key file"
}
