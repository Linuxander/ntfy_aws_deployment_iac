variable "project_name" {
  description = "Project name variable for tagging resources."
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

# --- BEGINS: vpc_default variables ---
variable "vpc_default_cidr" {
  description = "This is the CIDR used for vpc_default resource"
  default     = "10.3.0.0/16"
}
# --- ENDS: vpc variables ---

# --- BEGINS: subnet_default variables ---
variable "subnet_default_cidr" {
  description = "This is the CIDR used for subnet_default resource"
  default     = "10.3.6.0/24"
}
# --- ENDS: subnet_default variables ---

# --- BEGINS: route_table_default variables ---
variable "route_table_default_cidr" {
  description = "This is the CIDR used for route_table_default resource"
  default     = "0.0.0.0/0"
}
# --- ENDS: route_table_default variables ---
