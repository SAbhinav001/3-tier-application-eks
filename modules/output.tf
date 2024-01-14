output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_id"{
 value = aws_subnet.pub_sub[*].id
}

output "private_subnet_id"{
    value = aws_subnet.pvt_sub[*].id
}
