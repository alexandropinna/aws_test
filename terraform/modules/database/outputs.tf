# --- Outputs for the RDS (Relational Database Service) database ---

# Connection address for the RDS database
output "db_host" {
  value       = aws_db_instance.my_rds.endpoint
  description = "The connection address for the RDS database"
}

# Connection port for the RDS database
output "db_port" {
  value       = aws_db_instance.my_rds.port
  description = "The port for the RDS database"
}

# Username for accessing the RDS database
output "db_username" {
  value       = aws_db_instance.my_rds.username
  description = "The username for the RDS database"
}

# Password for accessing the RDS database
# Marked as sensitive to prevent accidental exposure
output "db_password" {
  value       = var.rds_password
  description = "The password for the RDS database. Handle with care!"
  sensitive   = true
}

# Name of the subnet group associated with the RDS database
output "db_subnet_group" {
  value       = aws_db_subnet_group.my_db_subnet_group.name
  description = "The name of the subnet group for the RDS database"
}
