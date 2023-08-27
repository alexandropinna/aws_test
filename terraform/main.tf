# Security Group Module
# Configura las reglas de seguridad de red para permitir/denegar el tráfico.
module "security_group" {
  source = "./modules/security_group" # Ruta al módulo de Security Group

  # Lista de puertos para las reglas de entrada
  ingress_ports_list = var.ingress_ports_list
  # CIDR para permitir el tráfico entrante
  sg_ingress_cidr = var.sg_ingress_cidr
  # CIDR para permitir el acceso a RDS
  rds_access_cidr = var.rds_access_cidr
  # ID de la VPC donde se creará el grupo de seguridad
  vpc_id = module.vpc.vpc_id

  # Etiquetas para el recurso
  tags = var.tags
}

# VPC Module
# Configura la VPC (Virtual Private Cloud) y sus recursos asociados.
module "vpc" {
  source = "./modules/vpc" # Ruta al módulo de VPC

  # CIDR de la VPC
  virginia_cidr = var.virginia_cidr
  # Configuración de subredes
  subnets = var.subnets
  # Lista de puertos para las reglas de entrada
  ingress_ports_list = var.ingress_ports_list
  # CIDR para permitir el tráfico entrante
  sg_ingress_cidr = var.sg_ingress_cidr

  # Etiquetas para el recurso
  tags = var.tags
}

# EC2 Module
# Configura las instancias EC2 (Elastic Compute Cloud).
module "compute" {
  source = "./modules/compute" # Ruta al módulo de EC2

  # Número de instancias y sus especificaciones
  instancias = var.instancias
  ec2_specs  = var.ec2_specs
  # ID de la subred pública
  public_subnet_id = module.vpc.public_subnet_id
  # Nombre de la clave SSH
  key_name = data.aws_key_pair.key.key_name
  # ID del grupo de seguridad para instancias públicas
  public_security_group_id = module.security_group.sg_public_instance_id

  # Etiquetas para el recurso
  tags = var.tags
}

# ECS Module
# Configura el servicio ECS (Elastic Container Service).
module "ecs" {
  source = "./modules/ecs" # Ruta al módulo de ECS

  # Nombre del cluster, tarea y servicio
  cluster_name = "arroyo-cluster-v1"
  task_name    = "web-task"
  service_name = "web-service"
  # ID de la subred pública
  public_subnet_id = module.vpc.public_subnet_id
  # ID del grupo de seguridad para instancias públicas
  sg_public_instance_id = module.security_group.sg_public_instance_id

  # Detalles de la base de datos
  db_host     = module.database.db_host
  db_port     = module.database.db_port
  db_username = module.database.db_username
  db_password = module.database.db_password

  # Etiquetas para el recurso
  tags = var.tags
}

# RDS Module
# Configura la base de datos RDS (Relational Database Service).
module "database" {
  source = "./modules/database" # Ruta al módulo de RDS

  # ID de la VPC donde se creará la base de datos
  vpc_id = module.vpc.vpc_id
  # CIDR para permitir el acceso a RDS
  rds_access_cidr = var.rds_access_cidr
  # Contraseña de la base de datos
  rds_password = var.rds_password
  # ID de las subredes privadas
  private_subnet_id = module.vpc.private_subnet_ids
  # ID del grupo de seguridad para RDS
  rds_security_group_id = module.security_group.rds_sg_id

  # Etiquetas para el recurso
  tags = var.tags
}
