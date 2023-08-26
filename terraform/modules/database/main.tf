resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-database-subnet-group"
  subnet_ids = var.private_subnet_id

  tags = {
    Name = "my-database-subnet-group-${local.sufix}"
  }
}

# Crear una instancia de base de datos RDS
resource "aws_db_instance" "my_rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "12.11"
  instance_class       = "db.t3.micro"
  username             = "my_db_user"
  password             = var.rds_password
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name 
  
  vpc_security_group_ids = [var.rds_security_group_id]

  tags = {
    "Name" = "rds-${local.sufix}"
  }
}
