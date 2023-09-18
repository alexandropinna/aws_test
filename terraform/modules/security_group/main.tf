# --- Security Group for Public Instances ---

# Create a security group for public instances in AWS
resource "aws_security_group" "sg_public_instance" {
  # Name and description of the security group
  name        = "Public Instance SG"
  description = "Allow SSH inbound traffic and ALL egress traffic"

  # ID of the VPC where the security group will be created
  vpc_id = var.vpc_id

  # Dynamic ingress rules based on the list of ingress ports
  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ingress.value == 22 ? [var.ssh_allowed_cidr] : [var.sg_ingress_cidr]
    }
  }

  # Egress rule to allow all outgoing traffic
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Egress rule to allow HTTPS traffic (port 443)
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Tags for the security group
  tags = {
    Name = "Public Instance SG-${local.sufix}"
  }
}

# --- Security Group for RDS (Relational Database Service) ---

# Create a security group for the RDS database in AWS
resource "aws_security_group" "rds_sg" {
  # Name and description of the security group
  name        = "rds-${local.sufix}"
  description = "RDS Security Group"

  # ID of the VPC where the security group will be created
  vpc_id = var.vpc_id

  # Ingress rule to allow PostgreSQL traffic (port 5432)
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.rds_access_cidr]
  }

  # Tags for the security group
  tags = {
    Name = "RDS SG-${local.sufix}"
  }
}
