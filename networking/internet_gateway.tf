resource "aws_internet_gateway" "internet_gateway_default" {
  vpc_id = aws_vpc.vpc_default.id

  tags = {
    Name = "${var.project_name} - internet gateway"
  }
}