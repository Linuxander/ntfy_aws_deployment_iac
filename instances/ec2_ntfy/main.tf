# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}


locals {
  project_name = "NTFY-SERVER"
}

resource "aws_instance" "ec2_ntfy" {
  ami           = "ami-0440d3b780d96b29d"
  instance_type = "t3.micro"

  key_name   = "aws_key_pair_ec2_ntfy_server"
  monitoring = true

  subnet_id              = var.netmod_ntfy_sub_id
  vpc_security_group_ids = [var.netmod_ntfy_sg_id]

  associate_public_ip_address = true

  user_data = file("${path.module}/scripts/ec2-ntfy-server-user-data.sh")

  tags = {
    Name = "${local.project_name} - ec2 - ntfy"
  }
}