### VPC
variable "virginia_cidr" {
  description = "CIDR Virginia"
  type        = string
}

variable "subnets" {
  description = "Lista de subnets"
  type        = list(string)
}

variable "ingress_ports_list" {
  description = "Lista de puertos de ingress"
  type        = list(number)
}

variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

### ec2
variable "ec2_specs" {
  description = "Parametros de la instancia"
  type        = map(string)
}

variable "instancias" {
  type        = set(string)
  default     = ["apache"]
  description = "Nombre de las instancias"
}

### RDS
variable "rds_password" {
  description = "Contraseña para el usuario de la base de datos RDS"
  type        = string
}

variable "rds_access_cidr" {
  description = "Bloque CIDR que tiene permitido acceder a la base de datos RDS"
  type        = string
}

### global tags
variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}