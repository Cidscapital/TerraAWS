module "vpc" {
  source = "./vpc"
  region             = "us-east-1"
  vpc_cidr_block     = "192.168.0.0/16"
  availability_zones = ["us-east-1"]
}

module "security_group" {
  source = "./security_group"
  region = "us-east-1"
}

module "ec2" {
  source = "./ec2"
  region      = "us-east-1"
  ami         = "ami-02d7fd1c2af6eead0"
  instance_type = "t2.micro"
  ec2_count   = 4
  subnet_ids      = module.vpc.public_subnet_ids  # Pass subnet IDs here
  security_group_id    = module.security_group.security_group_id  # Pass security group ID here
}
