# --- Outputs for VPC and Subnets ---

# ID of the public subnet
output "public_subnet_id" {
  value       = aws_subnet.public_subnet.id
  description = "The ID of the public subnet in the VPC"
}

# IDs of the private subnets for RDS
output "private_subnet_ids" {
  value       = [aws_subnet.rds_subnet_1.id, aws_subnet.rds_subnet_2.id]
  description = "The list of IDs for the private subnets for the RDS database"
}

# ID of the VPC
output "vpc_id" {
  value       = aws_vpc.vpc_virginia.id
  description = "The ID of the VPC where the resources are created"
}
