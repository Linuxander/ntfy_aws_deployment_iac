variable "project_name" {
  description = "Project name variable for tagging resources."
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
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