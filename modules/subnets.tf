#public-subnet
resource "aws_subnet" "pub_sub" {
  count = length(var.cidr_public_subnet)
  vpc_id     = aws_vpc.vpc.id
   cidr_block = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.eu_availability_zone, count.index)

  tags = merge(
    {
    Name = "pub_subet ${count.index + 1}"
  },
  var.public_subnet_tags
  ) 

}

#public-subnet
resource "aws_subnet" "pvt_sub" {
  count = length(var.cidr_private_subnet)  
  vpc_id     = aws_vpc.vpc.id
  cidr_block = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.eu_availability_zone, count.index)


  tags = merge(
    {
    Name = "pvt_subnet ${count.index + 1}"
  },
  var.private_subnet_tags
  ) 
}