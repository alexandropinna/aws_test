output "instances" {
  value = {
    for instance in aws_instance.public_instance : instance.tags["Name"] => {
      id           = instance.id
      name         = instance.tags["Name"]
      public_ip    = instance.public_ip
      instance_type = instance.instance_type
    }
  }
  description = "Details of the created EC2 instances."
}
