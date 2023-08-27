# Recurso para crear instancias EC2 en AWS
# Estas instancias están destinadas a ser instancias públicas accesibles desde Internet
resource "aws_instance" "public_instance" {
  # Utiliza `for_each` para crear múltiples instancias basadas en la variable `instancias`
  for_each = var.instancias

  # ID de la imagen de la máquina (AMI) para la instancia
  # En este caso, se usa Debian 11 con Docker preinstalado
  ami = var.ec2_specs.ami

  # Tipo de instancia EC2 (por ejemplo, t2.micro, t3.small, etc.)
  instance_type = var.ec2_specs.instance_type

  # ID de la subred pública donde se lanzará la instancia
  subnet_id = var.public_subnet_id

  # Nombre del par de claves para acceder a la instancia
  key_name = var.key_name

  # IDs de los grupos de seguridad asociados con la instancia
  vpc_security_group_ids = [var.public_security_group_id]

  # Etiquetas para la instancia EC2
  # El nombre se construye utilizando el valor actual de `for_each` y el sufijo local
  tags = {
    "Name" = "${each.value}-${local.sufix}"
  }
}
