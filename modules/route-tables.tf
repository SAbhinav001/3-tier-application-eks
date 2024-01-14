resource "aws_route_table" "pub-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "route table public"
  }
}

resource "aws_route_table" "pvt-route-table" {
  vpc_id = aws_vpc.vpc.id

  count  = length(var.cidr_private_subnet) 

  depends_on = [aws_nat_gateway.nat_gateway]

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }

  tags = {
    Name = "route table pvt"
  }
}