output "instance_public_ips" {
  description = "Public IP addresses of the EC2 instances"
  value       = module.ec2.instance_public_ips
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.security_group.security_group_id
}
