# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

# variable "this_db_password" {
#   description = "RDS root user password"
#   sensitive   = true
# }

# variable "ec2_ntfy_server_ip" {
#   description = "The IP of the ntfy server"
#   type = string
# }