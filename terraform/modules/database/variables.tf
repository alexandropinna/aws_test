# --- Variables para la base de datos RDS (Relational Database Service) ---

# ID de la VPC en la que se lanzará la instancia de la base de datos RDS
variable "vpc_id" {
  description = "El ID de la VPC donde se lanzará la instancia RDS"
  type        = string
}

# Bloque CIDR que tiene permitido acceder a la base de datos RDS
variable "rds_access_cidr" {
  description = "Bloque CIDR que tiene permitido acceder a la base de datos RDS"
  type        = string
}

# Contraseña para el usuario de la base de datos RDS
variable "rds_password" {
  description = "Contraseña para el usuario de la base de datos RDS"
  type        = string
}

# IDs de las subredes privadas en las que se lanzará la base de datos RDS
variable "private_subnet_id" {
  description = "Nombre del grupo de subredes de la base de datos RDS"
  type        = list(string)
}

# ID del grupo de seguridad que se asociará a la instancia de la base de datos RDS
variable "rds_security_group_id" {
  description = "The ID of the security group to associate with the RDS instance"
  type        = string
}

# --- Variables globales para etiquetas (tags) ---

# Etiquetas generales para todos los recursos del proyecto
variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}