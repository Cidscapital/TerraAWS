resource "aws_instance" "ec2" {
  count         = var.ec2_count
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_ids, count.index)  # Updated line
  key_name      = "tf-key"
  security_groups = [var.security_group_id]  # Use the passed security group ID

  user_data = <<-EOF
              #!/bin/bash
              sudo yum install docker -y
              sudo service docker start
              sudo docker run -d -p 80:80 nginx
              sudo docker run -d -p 8080:8080 nginx
              sudo docker run -d -p 8081:8081 nginx
              EOF

  tags = {
    Name = "EC2Instance-${count.index}"
  }
}

output "ec2_public_ips" {
  value = aws_instance.ec2[*].public_ip
}
