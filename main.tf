module "vpc" {
  source           = "./modules/vpc"
  vpc_cidr_block   = "192.168.0.0/16"
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source     = "./modules/ec2"
  subnet_ids = module.vpc.public_subnet_ids
  ami        = var.ami
  instance_type = var.instance_type
  key_name   = var.key_name
}
