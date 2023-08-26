variable "vpc_id" {
  description = "El ID de la VPC donde se lanzará la instancia RDS"
  type        = string
}

variable "rds_access_cidr" {
  description = "Bloque CIDR que tiene permitido acceder a la base de datos RDS"
  type        = string
}

variable "rds_password" {
  description = "Contraseña para el usuario de la base de datos RDS"
  type        = string
}

variable "private_subnet_id" {
  description = "Nombre del grupo de subredes de la base de datos RDS"
  type        = list(string)
}

variable "rds_security_group_id" {
  description = "The ID of the security group to associate with the RDS instance"
  type        = string
}



### global tags
variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}