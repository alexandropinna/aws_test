### Public Instace SG
resource "aws_security_group" "sg_public_instance" {
  name        = "Public Instance SG"
  description = "Allow SSH inbound traffic and ALL egress traffic"
  vpc_id            = var.vpc_id 

  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ingress.value == 22 ? [var.ssh_allowed_cidr] : [var.sg_ingress_cidr]
    }
  }
 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public Instance SG-${local.sufix}"
  }
}

### RDS SG
resource "aws_security_group" "rds_sg" {
  name        = "rds-${local.sufix}"
  description = "RDS Security Group"
  vpc_id            = var.vpc_id 
  
  ingress {
    from_port   = 5432  
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.rds_access_cidr]
  }
  tags = {
    Name = "RDS SG-${local.sufix}"
  }
}