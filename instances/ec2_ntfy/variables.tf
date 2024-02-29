# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "netmod_ntfy_vpc_id" {
  description = "Network module netmod_ntfy_vpc_id reference"
  default     = ""
}

variable "netmod_ntfy_sg_id" {
  description = "Network module netmod_ntfy_sg_id reference"
  default     = ""
}

variable "netmod_ntfy_sub_id" {
  description = "Network module netmod_ntfy_sub_id reference"
  default     = ""
}