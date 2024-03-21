resource "aws_security_group" "security_group_default" {
  name        = "security_group_default"
  description = "Security group for allowing HTTP, HTTPS, and SSH"
  vpc_id      = aws_vpc.vpc_default.id

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
    Name = "${var.project_name} - security group"
  }
}