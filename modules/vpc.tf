#VPC
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = merge(
    {
    Name = var.vpc_name
  },
  var.vpc_tags
  )
}





