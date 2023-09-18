# --- VPC (Virtual Private Cloud) ---

# Create a VPC in Virginia
resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    "Name" = "vpc_virginia-${local.sufix}"
  }
}

# --- Subnets ---

# Create a public subnet in the VPC
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public_subnet-${local.sufix}"
  }
}

# Create the first subnet for RDS in the VPC
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

# Create the second subnet for RDS in the VPC
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

# Create an Internet Gateway and associate it with the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id
  tags = {
    Name = "igw vpc virginia-${local.sufix}"
  }
}

# --- Route Tables ---

# Create a public route table for the VPC
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

# Associate the public subnet with the public route table
resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}
