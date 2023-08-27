# --- Variables para la VPC (Virtual Private Cloud) ---

# CIDR de la VPC en la región de Virginia
variable "virginia_cidr" {
  description = "CIDR Virginia"
  type        = string
}

# Lista de subredes para la VPC
variable "subnets" {
  description = "Lista de subnets"
  type        = list(string)
}

# Lista de puertos para las reglas de tráfico entrante (ingress)
variable "ingress_ports_list" {
  description = "Lista de puertos de ingress"
  type        = list(number)
}

# CIDR para el tráfico entrante (ingress) a la VPC
variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

# --- Variables para las instancias EC2 (Elastic Compute Cloud) ---

# Especificaciones de la instancia EC2 como tipo, tamaño del disco, etc.
variable "ec2_specs" {
  description = "Parametros de la instancia"
  type        = map(string)
}

# Conjunto de nombres para las instancias EC2
variable "instancias" {
  type        = set(string)
  default     = ["apache"]
  description = "Nombre de las instancias"
}

# --- Variables para la base de datos RDS (Relational Database Service) ---

# Contraseña para el usuario de la base de datos RDS
variable "rds_password" {
  description = "Contraseña para el usuario de la base de datos RDS"
  type        = string
}

# Bloque CIDR que tiene permitido acceder a la base de datos RDS
variable "rds_access_cidr" {
  description = "Bloque CIDR que tiene permitido acceder a la base de datos RDS"
  type        = string
}

# --- Variables globales para etiquetas (tags) ---

# Etiquetas generales para todos los recursos del proyecto
variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}
