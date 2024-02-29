# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "subnet_cidr_ntfy" {
  description = "This is the CIDR used for ntfy"
  default     = "10.3.6.0/24"
}