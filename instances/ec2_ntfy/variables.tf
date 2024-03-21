# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "project_name" {
  default = "ENTER_PROJECT_NAME_HERE"
}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "netmod_vpc_default_id" {
  description = "Network module netmod_vpc_default_id reference"
  default     = ""
}

variable "netmod_security_group_default_id" {
  description = "Network module netmod_security_group_default_id reference"
  default     = ""
}

variable "netmod_subnet_default_id" {
  description = "Network module netmod_subnet_default_id reference"
  default     = ""
}