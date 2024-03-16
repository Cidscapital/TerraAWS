resource "aws_security_group" "tf_sg" {
  name        = "tf-sg"
  description = "Security group for Terraform resources"
  
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow access to Docker containers
  }

  // Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }

  tags = {
    Name = "tf-sg"
  }
}

resource "aws_security_group_rule" "allow_dns_ingress" {
  type              = "ingress"
  from_port         = 53
  to_port           = 53
  protocol          = "udp"
  security_group_id = aws_security_group.tf_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow DNS queries (UDP) from anywhere"
}

resource "aws_security_group" "allow_dns_egress" {
  name        = "egress"
  description = "Allow DNS egress"

  vpc_id = var.vpc_id

  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "security_group_id" {
  value = aws_security_group.tf_sg.id
}
