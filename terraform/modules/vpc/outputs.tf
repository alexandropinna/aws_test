# --- Salidas para VPC y Subredes ---

# ID de la subred pública
output "public_subnet_id" {
  value       = aws_subnet.public_subnet.id
  description = "El ID de la subred pública en la VPC"
}

# IDs de las subredes privadas para RDS
output "private_subnet_ids" {
  value       = [aws_subnet.rds_subnet_1.id, aws_subnet.rds_subnet_2.id]
  description = "La lista de IDs de las subredes privadas para la base de datos RDS"
}

# ID de la VPC
output "vpc_id" {
  value       = aws_vpc.vpc_virginia.id
  description = "El ID de la VPC en la que se crean los recursos"
}