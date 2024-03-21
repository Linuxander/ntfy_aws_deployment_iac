resource "aws_route_table" "route_table_default" {
  vpc_id = aws_vpc.vpc_default.id
  route {
    cidr_block = var.route_table_default_cidr
    gateway_id = aws_internet_gateway.internet_gateway_default.id
  }
  tags = {
    Name = "${var.project_name} - route table"
  }
}

resource "aws_route_table_association" "route_table_default_association" {
  subnet_id      = aws_subnet.subnet_default.id
  route_table_id = aws_route_table.route_table_default.id
}