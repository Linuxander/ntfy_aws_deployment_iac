# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}


locals {
  project_name = "NTFY-SERVER"
}

data "aws_ami" "latest_t3_micro_ami" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
resource "aws_instance" "ec2_ntfy" {
  ami           = data.aws_ami.latest_t3_micro_ami.id
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