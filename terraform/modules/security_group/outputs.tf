# --- Outputs for Security Groups ---

# ID of the security group for the RDS database
output "rds_sg_id" {
  value       = aws_security_group.rds_sg.id
  description = "The ID of the security group for the RDS database"
}

# ID of the security group for public instances
output "sg_public_instance_id" {
  value       = aws_security_group.sg_public_instance.id
  description = "The ID of the security group for public instances"
}
