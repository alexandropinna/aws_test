# --- Variables para las instancias EC2 (Elastic Compute Cloud) ---

# Mapa de especificaciones para las instancias EC2 como tipo de instancia, tamaño de disco, etc.
variable "ec2_specs" {
  description = "Parametros de la instancia"
  type        = map(string)
}

# Conjunto de nombres para las instancias EC2, por defecto incluye "apache"
variable "instancias" {
  type        = set(string)
  default     = ["apache"]
  description = "Nombre de las instancias"
}

# ID de la subred pública en la que se lanzarán las instancias EC2
variable "public_subnet_id" {
  description = "El ID de la subred pública para usar con las instancias EC2"
  type        = string
}

# ID del grupo de seguridad que se asignará a las instancias EC2 públicas
variable "public_security_group_id" {
  description = "ID del Security Group para instancias públicas"
  type        = string
}

# Nombre del par de claves EC2 para acceder a las instancias
variable "key_name" {
  description = "Nombre de la llave EC2"
  type        = string
}

# --- Variables globales para etiquetas (tags) ---

# Etiquetas generales para todos los recursos del proyecto
variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}
