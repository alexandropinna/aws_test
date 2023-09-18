# --- Variables for EC2 (Elastic Compute Cloud) instances ---

# Map of specifications for EC2 instances such as instance type, disk size, etc.
variable "ec2_specs" {
  description = "Instance parameters"
  type        = map(string)
}

# Set of names for EC2 instances, defaults to include "apache"
variable "instancias" {
  type        = set(string)
  default     = ["apache"]
  description = "Names of the instances"
}

# ID of the public subnet in which the EC2 instances will be launched
variable "public_subnet_id" {
  description = "The ID of the public subnet to use with the EC2 instances"
  type        = string
}

# ID of the security group that will be assigned to the public EC2 instances
variable "public_security_group_id" {
  description = "Security Group ID for public instances"
  type        = string
}

# Name of the EC2 key pair to access the instances
variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

# --- Global variables for tags ---

# General tags for all project resources
variable "tags" {
  description = "Project tags"
  type        = map(string)
}
