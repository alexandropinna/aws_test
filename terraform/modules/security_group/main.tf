# --- Grupo de seguridad para instancias públicas ---

# Crear un grupo de seguridad para instancias públicas en AWS
resource "aws_security_group" "sg_public_instance" {
  # Nombre y descripción del grupo de seguridad
  name        = "Public Instance SG"
  description = "Allow SSH inbound traffic and ALL egress traffic"

  # ID de la VPC en la que se creará el grupo de seguridad
  vpc_id = var.vpc_id

  # Reglas de entrada dinámicas basadas en la lista de puertos de entrada
  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ingress.value == 22 ? [var.ssh_allowed_cidr] : [var.sg_ingress_cidr]
    }
  }

  # Regla de salida para permitir todo el tráfico de salida
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Regla de salida para permitir tráfico HTTPS (puerto 443)
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Etiquetas para el grupo de seguridad
  tags = {
    Name = "Public Instance SG-${local.sufix}"
  }
}

# --- Grupo de seguridad para RDS (Relational Database Service) ---

# Crear un grupo de seguridad para la base de datos RDS en AWS
resource "aws_security_group" "rds_sg" {
  # Nombre y descripción del grupo de seguridad
  name        = "rds-${local.sufix}"
  description = "RDS Security Group"

  # ID de la VPC en la que se creará el grupo de seguridad
  vpc_id = var.vpc_id

  # Regla de entrada para permitir tráfico PostgreSQL (puerto 5432)
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.rds_access_cidr]
  }

  # Etiquetas para el grupo de seguridad
  tags = {
    Name = "RDS SG-${local.sufix}"
  }
}