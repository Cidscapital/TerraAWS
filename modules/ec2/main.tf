module "security_group" {
  source = "../security_group"  # Adjust the path as needed
  vpc_id = var.vpc_id
}
resource "aws_instance" "web_servers" {
  count                  = 4
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = element(var.subnet_ids, count.index)
  key_name               = "tf-key"
  vpc_security_group_ids = [module.security_group.security_group_id]  # Use the same security group for all instances
  
  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    apt-get install -y docker.io
    systemctl start docker
    docker pull nginx
    docker run -d -p 8080:80 nginx
    docker run -d -p 8081:80 nginx
  EOF
}
