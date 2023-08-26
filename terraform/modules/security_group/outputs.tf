output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}

# output "vpc_id" {
#   value = var.vpc_id
# }

output "sg_public_instance_id" {
  value = aws_security_group.sg_public_instance.id
}
