output "vpc_default_id" {
  description = "The ID of the vpc_default"
  value       = aws_vpc.vpc_default.id
}

output "subnet_default_id" {
  description = "The ID of the subnet_default"
  value       = aws_subnet.subnet_default.id
}

output "security_group_default_id" {
  description = "The ID of the security_group_default"
  value       = aws_security_group.security_group_default.id
}

