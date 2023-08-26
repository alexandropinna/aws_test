output "db_host" {
  value       = aws_db_instance.my_rds.endpoint
  description = "La dirección de conexión para la base de datos RDS"
}

output "db_port" {
  value       = aws_db_instance.my_rds.port
  description = "El puerto para la base de datos RDS"
}

output "db_username" {
  value       = aws_db_instance.my_rds.username
  description = "El nombre de usuario para la base de datos RDS"
}

output "db_password" {
  value       = var.rds_password
  description = "La contraseña para la base de datos RDS. ¡Manejar con cuidado!"
  sensitive   = true
}

output "db_subnet_group" {
  value       = aws_db_subnet_group.my_db_subnet_group.name
  description = "El nombre del grupo de subredes de la base de datos RDS"
}
