output "ntfs_server_instance_public_ip" {
  description = "The public IP address of the NTFS Server EC2 instance."
  value       = aws_instance.ec2_ntfy.public_ip
}