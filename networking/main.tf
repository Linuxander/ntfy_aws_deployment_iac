# Copyright (c) HashiCorp, Inc. 
# SPDX-License-Identifier: MPL-2.0 

provider "aws" {
  region = var.region
}

locals {
  project_name         = "NTFY-SERVER"
  allowed_ips_for_http = [for ip in split("\n", trimspace(file("${path.module}/data/allowed_ips_for_http.txt"))) : ip]
  allowed_ips_for_ssh  = [for ip in split("\n", trimspace(file("${path.module}/data/allowed_ips_for_ssh.txt"))) : ip]
}

resource "aws_vpc" "project_ntfy_vpc" {
  cidr_block           = "10.3.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${local.project_name} - vpc"
  }
}

resource "aws_subnet" "project_ntfy_subnet" {
  vpc_id                  = aws_vpc.project_ntfy_vpc.id
  cidr_block              = var.subnet_cidr_ntfy
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "${local.project_name} - subnet - ntfy"
  }
}

resource "aws_security_group" "project_ntfy_securitygroup" {
  name        = "project_ntfy_securitygroup"
  description = "Security group for allowing HTTP, HTTPS, and SSH"
  vpc_id      = aws_vpc.project_ntfy_vpc.id

  dynamic "ingress" {
    for_each = local.allowed_ips_for_http
    content {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
      description = "Allowed IP addresses"
    }
  }

  dynamic "ingress" {
    for_each = local.allowed_ips_for_http
    content {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
      description = "Allowed IP addresses"
    }
  }

  dynamic "ingress" {
    for_each = local.allowed_ips_for_ssh
    content {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
      description = "Allowed IP addresses"
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.project_name} - security group - ntfy"
  }
}

resource "aws_route_table" "project_ntfy_rt" {
  vpc_id = aws_vpc.project_ntfy_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project_ntfy_igw.id
  }
  tags = {
    Name = "${local.project_name} - route table - ntfy"
  }
}

resource "aws_route_table_association" "ntfy_rt_sub_association" {
  subnet_id      = aws_subnet.project_ntfy_subnet.id
  route_table_id = aws_route_table.project_ntfy_rt.id
}

resource "aws_internet_gateway" "project_ntfy_igw" {
  vpc_id = aws_vpc.project_ntfy_vpc.id

  tags = {
    Name = "${local.project_name} - internet gateway"
  }
}