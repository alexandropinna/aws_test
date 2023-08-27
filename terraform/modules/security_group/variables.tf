# --- Variables para Instancias Públicas y Grupos de Seguridad ---

# Lista de puertos que se permitirán en las reglas de entrada del grupo de seguridad
variable "ingress_ports_list" {
  description = "Lista de puertos de ingress"
  type        = list(number)
}

# Bloque CIDR que se permitirá en las reglas de entrada del grupo de seguridad
variable "sg_ingress_cidr" {
  description = "CIDR para trafico de ingress"
  type        = string
}

# Bloque CIDR que se permitirá en las reglas de entrada del grupo de seguridad de RDS
variable "rds_access_cidr" {
  description = "CIDR para RDS"
  type        = string
}

# ID de la VPC en la que se crearán las instancias y grupos de seguridad
variable "vpc_id" {
  description = "ID para la VPC"
  type        = string
}

# Bloque CIDR que se permitirá para el tráfico SSH
# Por defecto se permite todo el tráfico (0.0.0.0/0)
variable "ssh_allowed_cidr" {
  description = "Bloque CIDR permitido para SSH"
  type        = string
  default     = "0.0.0.0/0"
}

# --- Variables globales para etiquetas (tags) ---

# Etiquetas generales para todos los recursos del proyecto
variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}
