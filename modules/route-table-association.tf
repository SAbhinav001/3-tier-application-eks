resource "aws_route_table_association" "public_subnet_association" {
  count = length(var.cidr_public_subnet)
  depends_on = [aws_subnet.pub_sub, aws_route_table.pub-route-table]
  subnet_id      = element(aws_subnet.pub_sub[*].id, count.index)
  route_table_id = aws_route_table.pub-route-table.id
}


resource "aws_route_table_association" "private_subnet_association" {
  count = length(var.cidr_private_subnet)
  depends_on = [aws_subnet.pvt_sub, aws_route_table.pvt-route-table]
  subnet_id      = element(aws_subnet.pvt_sub[*].id, count.index)
  route_table_id = aws_route_table.pvt-route-table[count.index].id
}