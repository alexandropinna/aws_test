variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "task_name" {
  description = "Name of the ECS task"
  type        = string
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet"
  type        = string
}

variable "sg_public_instance_id" {
  description = "ID of the public instance security group"
  type        = string
}

variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}

# variables para RDS

variable "db_host" {
  description = "La dirección de conexión para la base de datos RDS"
  type        = string
}

variable "db_port" {
  description = "El puerto para la base de datos RDS"
  type        = string
}

variable "db_username" {
  description = "El nombre de usuario para la base de datos RDS"
  type        = string
}

variable "db_password" {
  description = "La contraseña para la base de datos RDS. ¡Manejar con cuidado!"
  type        = string
  sensitive   = true
}
