output "ec2_instance_public_ips" {
  description = "Public IP addresses of the EC2 instances"
  value       = aws_instance.web_servers[*].public_ip
}
