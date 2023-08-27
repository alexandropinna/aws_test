# --- VPC (Virtual Private Cloud) ---

# Crear una VPC en Virginia
resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    "Name" = "vpc_virginia-${local.sufix}"
  }
}

# --- Subredes ---

# Crear una subred pública en la VPC
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public_subnet-${local.sufix}"
  }
}

# Crear la primera subred para RDS en la VPC
resource "aws_subnet" "rds_subnet_1" {
  vpc_id            = aws_vpc.vpc_virginia.id
  cidr_block        = var.subnets[1]
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "rds_subnet_1-${local.sufix}"
  }
  depends_on = [
    aws_subnet.public_subnet
  ]
}

# Crear la segunda subred para RDS en la VPC
resource "aws_subnet" "rds_subnet_2" {
  vpc_id            = aws_vpc.vpc_virginia.id
  cidr_block        = var.subnets[2]
  availability_zone = "us-east-1b"
  tags = {
    "Name" = "rds_subnet_2-${local.sufix}"
  }
  depends_on = [
    aws_subnet.public_subnet
  ]
}

# --- Internet Gateway ---

# Crear una puerta de enlace a Internet y asociarla a la VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id
  tags = {
    Name = "igw vpc virginia-${local.sufix}"
  }
}

# --- Tablas de Rutas ---

# Crear una tabla de rutas pública para la VPC
resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public crt-${local.sufix}"
  }
}

# Asociar la subred pública con la tabla de rutas pública
resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}