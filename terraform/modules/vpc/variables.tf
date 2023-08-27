# --- Variables para VPC y Subredes ---

# Bloque CIDR para la VPC en la región de Virginia
variable "virginia_cidr" {
  description = "CIDR Virginia"
  type        = string
}

# Lista de bloques CIDR para las subredes dentro de la VPC
variable "subnets" {
  description = "Lista de subnets"
  type        = list(string)
}

# Lista de puertos que se permitirán en las reglas de entrada del grupo de seguridad
variable "ingress_ports_list" {
  description = "Lista de puertos de ingress"
  type        = list(number)
}

# Bloque CIDR que se permitirá en las reglas de entrada del grupo de seguridad
variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

# --- Variables globales para etiquetas (tags) ---

# Etiquetas generales para todos los recursos del proyecto
variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}
