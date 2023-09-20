# --- Global variables for tags ---

# General tags for all project resources
variable "tags" {
  description = "Project tags"
  type        = map(string)
}

# --- Variables for the VPC (Virtual Private Cloud) ---

# CIDR of the VPC in the Virginia region
variable "virginia_cidr" {
  description = "Virginia CIDR"
  type        = string
}

# List of subnets for the VPC
variable "subnets" {
  description = "List of subnets"
  type        = list(string)
}

# List of ports for incoming traffic rules (ingress)
variable "ingress_ports_list" {
  description = "List of ingress ports"
  type        = list(number)
}

# CIDR for incoming traffic (ingress) to the VPC
variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

# --- Variables for EC2 (Elastic Compute Cloud) instances ---

# Specifications for the EC2 instance such as type, disk size, etc.
variable "ec2_specs" {
  description = "Instance parameters"
  type        = map(string)
}

# Set of names for the EC2 instances
variable "instancias" {
  type        = set(string)
  description = "Names of the instances"
} 

# --- Variables for the RDS (Relational Database Service) database ---

# Password for the RDS database user
variable "rds_password" {
  description = "Password for the RDS database user"
  type        = string
}

# CIDR block that is allowed to access the RDS database
variable "rds_access_cidr" {
  description = "CIDR block that is allowed to access the RDS database"
  type        = string
}

