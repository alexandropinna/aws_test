# --- Variables for ECS (Elastic Container Service) ---

# Name of the ECS cluster
variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

# Name of the ECS task
variable "task_name" {
  description = "Name of the ECS task"
  type        = string
}

# Name of the ECS service
variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

# ID of the public subnet for the ECS service
variable "public_subnet_id" {
  description = "ID of the public subnet"
  type        = string
}

# ID of the public instance security group for the ECS service
variable "sg_public_instance_id" {
  description = "ID of the public instance security group"
  type        = string
}

# --- Global variables for tags ---

# General tags for all project resources
variable "tags" {
  description = "Project tags"
  type        = map(string)
}

# --- Variables for RDS (Relational Database Service) ---

# Host address for the RDS database
variable "db_host" {
  description = "The connection address for the RDS database"
  type        = string
}

# Port for the RDS database
variable "db_port" {
  description = "The port for the RDS database"
  type        = string
}

# Username for the RDS database
variable "db_username" {
  description = "The username for the RDS database"
  type        = string
}

# Password for the RDS database
# Marked as sensitive to prevent accidental exposure
variable "db_password" {
  description = "The password for the RDS database. Handle with care!"
  type        = string
  sensitive   = true
}
