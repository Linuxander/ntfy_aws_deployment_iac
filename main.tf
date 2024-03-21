# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}

module "networking" {
  source                   = "./networking"
  project_name             = "NTFY-SERVER"
  region                   = var.region
  vpc_default_cidr         = "10.3.0.0/16"
  subnet_default_cidr      = "10.3.6.0/24"
  route_table_default_cidr = "0.0.0.0/0"
}

module "ec2_ntfy" {
  source                           = "./instances/ec2_ntfy"
  project_name                     = "NTFY-SERVER"
  netmod_vpc_default_id            = module.networking.vpc_default_id
  netmod_subnet_default_id         = module.networking.subnet_default_id
  netmod_security_group_default_id = module.networking.security_group_default_id
}

