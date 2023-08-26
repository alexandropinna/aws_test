output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_ids" {
  value = [aws_subnet.rds_subnet_1.id, aws_subnet.rds_subnet_2.id]
}

output "vpc_id" {
  value = aws_vpc.vpc_virginia.id
}
