resource "aws_eip" "nat_eip" {
  count = length(var.cidr_public_subnet)
  domain = "vpc"
}


resource "aws_nat_gateway" "nat_gateway" {
  count      = length(var.cidr_public_subnet)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id = aws_subnet.pub_sub[count.index].id

  depends_on = [aws_eip.nat_eip]



  tags = {
    "Name" = "public NAT GW"
  }
}