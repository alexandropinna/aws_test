resource "aws_instance" "public_instance" {
  for_each               = var.instancias
  ami                    = var.ec2_specs.ami # Debian 11 - docker
  instance_type          = var.ec2_specs.instance_type
  subnet_id = var.public_subnet_id
  key_name = var.key_name
  vpc_security_group_ids = [var.public_security_group_id]
  user_data = file("../scripts/install.sh")

  tags = {
    "Name" = "${each.value}-${local.sufix}"
  }
}