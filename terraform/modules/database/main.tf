# Resource to create a database subnet group in AWS
resource "aws_db_subnet_group" "my_db_subnet_group" {
  # Name of the database subnet group
  name = "my-database-subnet-group"

  # IDs of the private subnets where the RDS database will be launched
  subnet_ids = var.private_subnet_id

  # Tags for the database subnet group
  # The name is constructed using the local suffix
  tags = {
    Name = "my-database-subnet-group-${local.sufix}"
  }
}

# Resource to create an RDS database instance in AWS
resource "aws_db_instance" "my_rds" {
  # Allocated storage space (in GB)
  allocated_storage = 20

  # Storage type (gp2 is general-purpose storage)
  storage_type = "gp2"

  # Database engine type and its version
  engine         = "postgres"
  engine_version = "12.11"

  # Database instance type
  instance_class = "db.t3.micro"

  # Username and password for the database
  username = "my_db_user"
  password = var.rds_password

  # Skip the creation of a final snapshot when deleting the database instance
  skip_final_snapshot = true

  # Name of the database subnet group
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name

  # IDs of the security groups associated with the database instance
  vpc_security_group_ids = [var.rds_security_group_id]

  # Tags for the RDS database instance
  # The name is constructed using the local suffix
  tags = {
    "Name" = "rds-${local.sufix}"
  }
}
