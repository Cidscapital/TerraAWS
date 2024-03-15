resource "aws_instance" "web_servers" {
  count         = length(var.subnet_ids)
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_ids[count.index]

  user_data = <<-EOF
              #!/bin/bash
              yum install docker -y
              systemctl start docker
              docker run -d -p 8080:80 nginx
              docker run -d -p 8081:80 nginx
              EOF
}

output "instance_public_ips" {
  value = aws_instance.web_servers[*].public_ip
}
