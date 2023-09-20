# Security Group Module
# Configures the network security rules to allow/deny traffic.
module "security_group" {
  source = "./modules/security_group" # Path to the Security Group module

  # List of ports for inbound rules
  ingress_ports_list = var.ingress_ports_list
  # CIDR to allow incoming traffic
  sg_ingress_cidr = var.sg_ingress_cidr
  # CIDR to allow access to RDS
  rds_access_cidr = var.rds_access_cidr
  # ID of the VPC where the security group will be created
  vpc_id = module.vpc.vpc_id

  # Tags for the resource
  tags = var.tags
}

# VPC Module
# Configures the VPC (Virtual Private Cloud) and its associated resources.
module "vpc" {
  source = "./modules/vpc" # Path to the VPC module

  # VPC CIDR
  virginia_cidr = var.virginia_cidr
  # Subnet configuration
  subnets = var.subnets
  # List of ports for inbound rules
  ingress_ports_list = var.ingress_ports_list
  # CIDR to allow incoming traffic
  sg_ingress_cidr = var.sg_ingress_cidr

  # Tags for the resource
  tags = var.tags
}

# EC2 Module
# Configures the EC2 (Elastic Compute Cloud) instances.
module "compute" {
  source = "./modules/compute" # Path to the EC2 module

  # Number of instances and their specifications
  instancias = var.instancias
  ec2_specs  = var.ec2_specs
  # ID of the public subnet
  public_subnet_id = module.vpc.public_subnet_id
  # SSH key name
  key_name = data.aws_key_pair.key.key_name
  # Security group ID for public instances
  public_security_group_id = module.security_group.sg_public_instance_id

  # Tags for the resource
  tags = var.tags
}

# # ECS Module
# # Configures the ECS (Elastic Container Service) service.
# module "ecs" {
#   source = "./modules/ecs" # Path to the ECS module

#   # Name of the cluster, task, and service
#   cluster_name = "aws-cluster-v1"
#   task_name    = "web-task"
#   service_name = "web-service"
#   # ID of the public subnet
#   public_subnet_id = module.vpc.public_subnet_id
#   # Security group ID for public instances
#   sg_public_instance_id = module.security_group.sg_public_instance_id

#   # Database details
#   db_host     = module.database.db_host
#   db_port     = module.database.db_port
#   db_username = module.database.db_username
#   db_password = module.database.db_password

#   # Tags for the resource
#   tags = var.tags
# }

# # RDS Module
# # Configures the RDS (Relational Database Service) database.
# module "database" {
#   source = "./modules/database" # Path to the RDS module

#   # ID of the VPC where the database will be created
#   vpc_id = module.vpc.vpc_id
#   # CIDR to allow access to RDS
#   rds_access_cidr = var.rds_access_cidr
#   # Database password
#   rds_password = var.rds_password
#   # ID of the private subnets
#   private_subnet_id = module.vpc.private_subnet_ids
#   # Security group ID for RDS
#   rds_security_group_id = module.security_group.rds_sg_id

#   # Tags for the resource
#   tags = var.tags
# }
