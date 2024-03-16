provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

resource "aws_vpc" "tf-vpc" {
  cidr_block     = "192.168.0.0/16"
  tags = {
    Name = "tf-vpc"
  }
}

resource "aws_subnet" "tf-subnet-1" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "tf-subnet-1"
  }
}

resource "aws_subnet" "tf-subnet-2" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "tf-subnet-2"
  }
}

resource "aws_subnet" "tf-subnet-3" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = "192.168.3.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "tf-subnet-3"
  }
}

resource "aws_subnet" "tf-subnet-4" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = "192.168.4.0/24"
  availability_zone = "us-east-1d"
  tags = {
    Name = "tf-subnet-4"
  }
}

resource "aws_internet_gateway" "tf-igw" {
  vpc_id = aws_vpc.tf-vpc.id
  tags = {
    Name = "tf-vpc-IGW"
    }
}

resource "aws_route_table" "tf-route-table" {
  vpc_id = aws_vpc.tf-vpc.id
  tags = {
    Name = "tf-route-table"
  }
}

resource "aws_route" "tf-route" {
  route_table_id         = aws_route_table.tf-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tf-igw.id
}

resource "aws_route_table_association" "tf-subnet-1-association" {
  subnet_id      = aws_subnet.tf-subnet-1.id
  route_table_id = aws_route_table.tf-route-table.id
}

resource "aws_route_table_association" "tf-subnet-2-association" {
  subnet_id      = aws_subnet.tf-subnet-2.id
  route_table_id = aws_route_table.tf-route-table.id
}

resource "aws_route_table_association" "tf-subnet-3-association" {
  subnet_id      = aws_subnet.tf-subnet-3.id
  route_table_id = aws_route_table.tf-route-table.id
}

resource "aws_route_table_association" "tf-subnet-4-association" {
  subnet_id      = aws_subnet.tf-subnet-4.id
  route_table_id = aws_route_table.tf-route-table.id
}

resource "aws_security_group" "web-sg" {
  vpc_id = aws_vpc.tf-vpc.id
  name   = "web-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow access to Docker containers
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

resource "aws_instance" "tf-instance-1" {
  ami           = "ami-080e1f13689e07408 "
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.tf-subnet-1.id
  key_name      = "tf-key"
  tags = {
    Name = "tf-instance-1"
  }
}

resource "aws_instance" "tf-instance-2" {
  ami           = "ami-080e1f13689e07408 "
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.tf-subnet-2.id
  key_name      = "tf-key"
  tags = {
    Name = "tf-instance-2"
  }
}

resource "aws_instance" "tf-instance-3" {
  ami           = "ami-080e1f13689e07408 "
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.tf-subnet-3.id
  key_name      = "tf-key"
  tags = {
    Name = "tf-instance-3"
  }
}

resource "aws_instance" "tf-instance-4" {
  ami           = "ami-080e1f13689e07408 "
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.tf-subnet-4.id
  key_name      = "tf-key"
  tags = {
    Name = "tf-instance-4"
  }
}