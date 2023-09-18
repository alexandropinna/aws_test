# --- Variables for VPC and Subnets ---

# CIDR block for the VPC in the Virginia region
variable "virginia_cidr" {
  description = "CIDR for Virginia"
  type        = string
}

# List of CIDR blocks for the subnets within the VPC
variable "subnets" {
  description = "List of subnets"
  type        = list(string)
}

# List of ports that will be allowed in the security group's inbound rules
variable "ingress_ports_list" {
  description = "List of ingress ports"
  type        = list(number)
}

# CIDR block that will be allowed in the security group's inbound rules
variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

# --- Global Variables for Tags ---

# General tags for all the resources in the project
variable "tags" {
  description = "Project tags"
  type        = map(string)
}
