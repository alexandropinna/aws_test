module "security_group" {
  source = "./modules/security_group"

  ingress_ports_list = var.ingress_ports_list
  sg_ingress_cidr    = var.sg_ingress_cidr
  rds_access_cidr    = var.rds_access_cidr
  vpc_id             = module.vpc.vpc_id

  tags = var.tags
}

module "vpc" {
  source = "./modules/vpc"

  virginia_cidr      = var.virginia_cidr
  subnets            = var.subnets
  ingress_ports_list = var.ingress_ports_list
  sg_ingress_cidr    = var.sg_ingress_cidr

  tags = var.tags
}

### EC2
module "compute" {
  source = "./modules/compute"

  instancias               = var.instancias
  ec2_specs                = var.ec2_specs
  public_subnet_id         = module.vpc.public_subnet_id
  key_name                 = data.aws_key_pair.key.key_name
  public_security_group_id = module.security_group.sg_public_instance_id

  tags = var.tags
}

### ECS
module "ecs" {
  source = "./modules/ecs"

  cluster_name          = "arroyo-cluster"
  task_name             = "web-task"
  service_name          = "web-service"
  public_subnet_id      = module.vpc.public_subnet_id
  sg_public_instance_id = module.security_group.sg_public_instance_id
  
  db_host     = module.database.db_host
  db_port     = module.database.db_port
  db_username = module.database.db_username
  db_password = module.database.db_password

  tags = var.tags
}


## RDS
module "database" {
  source = "./modules/database"

  vpc_id            = module.vpc.vpc_id 
  rds_access_cidr   = var.rds_access_cidr
  rds_password      = var.rds_password
  private_subnet_id = module.vpc.private_subnet_ids
  rds_security_group_id = module.security_group.rds_sg_id

  tags = var.tags
}

