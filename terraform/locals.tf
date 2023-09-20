# Local Variables Block
# Used to define variables that are local to this configuration file.
locals {
  # Suffix composed of the project, environment, and region tags
  # Will be used for consistently naming resources across the project
  sufix = "${var.tags.project}-${var.tags.env}-${var.tags.region}"
  
  ec2_instances = module.compute.instances

  maquinas_ini_content = <<-EOT
    [ec2]
    ${join("\n", [for instance in values(local.ec2_instances) : instance.name])}
  EOT

  ssh_key_path = "/path/to/the/key.pem"

  ec2_host_vars_content = {for instance in values(local.ec2_instances) : instance.name => "ansible_host: ${instance.public_ip}\nansible_user: admin\nansible_ssh_private_key_file: ${local.ssh_key_path}"}

  host_vars_commands = join("\n", [
    for host, content in local.ec2_host_vars_content : "printf '%s' '${content}' > ../ansible/host_vars/${host}.yml"
  ])
}

resource "local_file" "maquinas_ini" {
  content  = local.maquinas_ini_content
  filename = "../ansible/maquinas.ini"


  provisioner "local-exec" {
    when    = destroy
    command = "rm -f ../ansible/maquinas.ini"
  }

  depends_on = [module.compute]
}

resource "null_resource" "host_vars" {
  triggers = {
    instance_ids = join(",", [for instance in values(local.ec2_instances) : instance.id])
  }

  provisioner "local-exec" {
    command = <<-EOT
      mkdir -p ../ansible/host_vars
      ${local.host_vars_commands}
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf ../ansible/host_vars"
  }

  depends_on = [module.compute]
}
