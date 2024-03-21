resource "aws_subnet" "subnet_default" {
  vpc_id                  = aws_vpc.vpc_default.id
  cidr_block              = var.subnet_default_cidr
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}a"

  tags = {
    Name = "${var.project_name} - subnet"
  }
}

