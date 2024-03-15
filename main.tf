# Configure AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Call VPC Module
module "vpc" {
  source = "./vpc"

  cidr_block = "192.168.0.0/16"  # Optional: Override default CIDR block
}

# Call Security Group Module
module "security_group" {
  source = "./security_group"
}

# Call EC2 Module
module "ec2" {
  source = "./ec2"

  public_subnet_ids = module.vpc.public_subnet_ids  # Access VPC module output
  ssh_key_name      = "tf-key"                         # Optional: Override default key name
  ami               = "ami-02d7fd1c2af6eead0"           # Update with desired AMI ID
}

# Output Public Subnet IDs (Optional)
output "vpc_public_subnet_ids" {
  value = module.vpc.public_subnet_ids
  description = "List of public subnet IDs"
}

# Output Security Group ID (Optional)
output "security_group_id" {
  value = module.security_group.security_group_id
  description = "ID of the security group"
}
