variable "ec2_specs" {
  description = "Parametros de la instancia"
  type        = map(string)
}

variable "instancias" {
  type        = set(string)
  default     = ["apache"]
  description = "Nombre de las instancias"
}

variable "public_subnet_id" {
  description = "El ID de la subred pública para usar con las instancias EC2"
  type        = string
}

variable "public_security_group_id" {
  description = "ID del Security Group para instancias públicas"
  type        = string
}

variable "key_name" {
  description = "Nombre de la llave EC2"
  type        = string
}

### global tags
variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}