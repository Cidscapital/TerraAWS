resource "aws_instance" "web_servers" {
  count         = 4
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_ids, count.index)

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y docker.io
              systemctl start docker
              docker run -d -p 8080:80 nginx
              docker run -d -p 8081:80 nginx
              EOF
}
