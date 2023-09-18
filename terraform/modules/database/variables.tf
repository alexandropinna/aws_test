# --- Variables for the RDS (Relational Database Service) database ---

# ID of the VPC where the RDS database instance will be launched
variable "vpc_id" {
  description = "The ID of the VPC where the RDS instance will be launched"
  type        = string
}

# CIDR block that is allowed to access the RDS database
variable "rds_access_cidr" {
  description = "CIDR block that is allowed to access the RDS database"
  type        = string
}

# Password for the RDS database user
variable "rds_password" {
  description = "Password for the RDS database user"
  type        = string
}

# IDs of the private subnets where the RDS database will be launched
variable "private_subnet_id" {
  description = "Name of the subnet group for the RDS database"
  type        = list(string)
}

# ID of the security group that will be associated with the RDS database instance
variable "rds_security_group_id" {
  description = "The ID of the security group to associate with the RDS instance"
  type        = string
}

# --- Global variables for tags ---

# General tags for all project resources
variable "tags" {
  description = "Project tags"
  type        = map(string)
}
