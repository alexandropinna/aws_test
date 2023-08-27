# --- Salidas para los Grupos de Seguridad ---

# ID del grupo de seguridad para la base de datos RDS
output "rds_sg_id" {
  value       = aws_security_group.rds_sg.id
  description = "El ID del grupo de seguridad para la base de datos RDS"
}

# ID del grupo de seguridad para las instancias públicas
output "sg_public_instance_id" {
  value       = aws_security_group.sg_public_instance.id
  description = "El ID del grupo de seguridad para las instancias públicas"
}
