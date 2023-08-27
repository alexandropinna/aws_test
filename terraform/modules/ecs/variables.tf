# --- Variables para ECS (Elastic Container Service) ---

# Nombre del cluster ECS
variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

# Nombre de la tarea ECS
variable "task_name" {
  description = "Name of the ECS task"
  type        = string
}

# Nombre del servicio ECS
variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

# ID de la subred pública para el servicio ECS
variable "public_subnet_id" {
  description = "ID of the public subnet"
  type        = string
}

# ID del grupo de seguridad de la instancia pública para el servicio ECS
variable "sg_public_instance_id" {
  description = "ID of the public instance security group"
  type        = string
}

# --- Variables globales para etiquetas (tags) ---

# Etiquetas generales para todos los recursos del proyecto
variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}

# --- Variables para RDS (Relational Database Service) ---

# Dirección del host de la base de datos RDS
variable "db_host" {
  description = "La dirección de conexión para la base de datos RDS"
  type        = string
}

# Puerto de la base de datos RDS
variable "db_port" {
  description = "El puerto para la base de datos RDS"
  type        = string
}

# Nombre de usuario para la base de datos RDS
variable "db_username" {
  description = "El nombre de usuario para la base de datos RDS"
  type        = string
}

# Contraseña para la base de datos RDS
# Marcada como sensible para evitar su exposición accidental
variable "db_password" {
  description = "La contraseña para la base de datos RDS. ¡Manejar con cuidado!"
  type        = string
  sensitive   = true
}