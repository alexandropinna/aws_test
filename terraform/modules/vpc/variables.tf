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


variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}
