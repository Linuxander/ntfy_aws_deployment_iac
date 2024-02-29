# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}

module "networking" {
  source     = "./networking"
}

module "ec2_ntfy" {
  source                   = "./instances/ec2_ntfy"
  netmod_ntfy_vpc_id = module.networking.project_ntfy_vpc_id
  netmod_ntfy_sg_id     = module.networking.ntfy_sg_id
  netmod_ntfy_sub_id    = module.networking.ntfy_sub_id
}

