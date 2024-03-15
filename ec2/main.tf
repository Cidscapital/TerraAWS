variable "ssh_key_name" {
  type = string
  default = "tf-key"
}

variable "ami" {
  type = string
  default = "ami-02d7fd1c2af6eead0"  # Update with desired Amazon Linux 2 AMI ID
}

resource "aws_instance" "web_server" {
  count = length(var.public_subnet_ids)

  ami           = var.ami
  instance_type = "t2.micro"

  vpc_security_group_ids = [module.security_group.security_group_id]

  # Access VPC module output for subnet IDs
  subnet_id = var.public_subnet_ids[count.index]

  key_name   = var.ssh_key_name

  user_data = <<EOF
#!/bin/bash
yum update -y
yum install -y docker docker-compose

# Build and run Nginx container on port 80
docker build -t my-nginx:latest <<EOF
FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html  # Replace with your actual website content
EOF

docker run -d --name my-nginx -p 80:80 my-nginx:latest

# Build and run custom Docker container on port 8080
docker build -t my-app:latest - <<EOF
# Replace with your Dockerfile content for container on port 8080
EOF

docker run -d --name my-app -p 8080:8080 my-app:latest

# Build and run another custom Docker container on port 8081
docker build -t my-other-app:latest - <<EOF
# Replace with your Dockerfile content for container on port 8081
EOF

docker run -d --name my-other-app -p 8081:8081 my-other-app:latest
EOF
}
