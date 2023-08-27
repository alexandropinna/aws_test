# Recurso para crear un grupo de subredes de base de datos en AWS
resource "aws_db_subnet_group" "my_db_subnet_group" {
  # Nombre del grupo de subredes de la base de datos
  name = "my-database-subnet-group"

  # IDs de las subredes privadas en las que se lanzará la base de datos RDS
  subnet_ids = var.private_subnet_id

  # Etiquetas para el grupo de subredes de la base de datos
  # El nombre se construye utilizando el sufijo local
  tags = {
    Name = "my-database-subnet-group-${local.sufix}"
  }
}

# Recurso para crear una instancia de base de datos RDS en AWS
resource "aws_db_instance" "my_rds" {
  # Espacio de almacenamiento asignado (en GB)
  allocated_storage = 20

  # Tipo de almacenamiento (gp2 es almacenamiento de propósito general)
  storage_type = "gp2"

  # Tipo de motor de base de datos y su versión
  engine         = "postgres"
  engine_version = "12.11"

  # Tipo de instancia de la base de datos
  instance_class = "db.t3.micro"

  # Nombre de usuario y contraseña para la base de datos
  username = "my_db_user"
  password = var.rds_password

  # Omitir la creación de un snapshot final al eliminar la instancia de la base de datos
  skip_final_snapshot = true

  # Nombre del grupo de subredes de la base de datos
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name

  # IDs de los grupos de seguridad asociados con la instancia de la base de datos
  vpc_security_group_ids = [var.rds_security_group_id]

  # Etiquetas para la instancia de la base de datos RDS
  # El nombre se construye utilizando el sufijo local
  tags = {
    "Name" = "rds-${local.sufix}"
  }
}
