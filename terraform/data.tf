# Recurso de datos para obtener información sobre un par de claves existente en AWS
# Esto se usa generalmente para acceder a instancias EC2
data "aws_key_pair" "key" {
  # Nombre del par de claves existente en AWS
  key_name = "arroyo-key-test"
}
