### Public Instace
variable "ingress_ports_list" {
  description = "Lista de puertos de ingress"
  type        = list(number)
}

variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

variable "rds_access_cidr" {
  description = "CIDR for RDS"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "Bloque CIDR permitido para SSH"
  type        = string
  default     = "0.0.0.0/0"
}

variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}