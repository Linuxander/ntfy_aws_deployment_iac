output "project_ntfy_vpc_id" {
  description = "The ID of the project_ntfy_vpc"
  value       = aws_vpc.project_ntfy_vpc.id
}

output "ntfy_sg_id" {
  description = "The ID of the project_ntfy_securitygroup"
  value       = aws_security_group.project_ntfy_securitygroup.id
}

output "ntfy_sub_id" {
  description = "The ID of the project_ntfy_subnet"
  value       = aws_subnet.project_ntfy_subnet.id
}