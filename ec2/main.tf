provider "aws" {
  region = var.region
}

resource "aws_key_pair" "tf_key" {
  key_name   = "tf-key"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "ec2" {
  count         = var.ec2_count
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_ids, count.index)  # Updated line
  key_name      = aws_key_pair.tf_key.key_name

  provisioner "remote-exec" {
    inline = [
      "sudo yum install docker -y",
      "sudo service docker start",
      "sudo docker run -d -p 80:80 nginx",
      "sudo docker run -d -p 8080:8080 nginx",
      "sudo docker run -d -p 8081:8081 nginx"
    ]
  }
}

output "ec2_public_ips" {
  value = aws_instance.ec2[*].public_ip
}
