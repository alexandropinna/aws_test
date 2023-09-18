# Resource to create EC2 instances in AWS
# These instances are intended to be public instances accessible from the Internet
resource "aws_instance" "public_instance" {
  # Uses `for_each` to create multiple instances based on the `instancias` variable
  for_each = var.instancias

  # ID of the machine image (AMI) for the instance
  # In this case, Debian 11 with Docker pre-installed is used
  ami = var.ec2_specs.ami

  # Type of EC2 instance (e.g., t2.micro, t3.small, etc.)
  instance_type = var.ec2_specs.instance_type

  # ID of the public subnet where the instance will be launched
  subnet_id = var.public_subnet_id

  # Name of the key pair to access the instance
  key_name = var.key_name

  # IDs of the security groups associated with the instance
  vpc_security_group_ids = [var.public_security_group_id]

  # Tags for the EC2 instance
  # The name is constructed using the current value from `for_each` and the local suffix
  tags = {
    "Name" = "${each.value}-${local.sufix}"
  }
}
