variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "task_name" {
  description = "Name of the ECS task"
  type        = string
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet"
  type        = string
}

variable "sg_public_instance_id" {
  description = "ID of the public instance security group"
  type        = string
}

variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}