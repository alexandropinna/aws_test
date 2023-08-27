# Bloque de configuración de Terraform
# Establece los requisitos para los proveedores y la versión de Terraform.
terraform {
  # Proveedores requeridos y sus versiones
  required_providers {
    # Proveedor AWS con versión mínima de 5.12.0
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.12.0"
    }

    # Proveedor Random con versión específica de 3.5.1
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }

  # Versión requerida de Terraform, compatible con la versión 1.5.0
  required_version = "~>1.5.0"
}

# Configuración del proveedor AWS
provider "aws" {
  # Región donde se desplegarán los recursos
  region = "us-east-1"

  # Etiquetas predeterminadas para todos los recursos creados
  default_tags {
    tags = var.tags
  }
}
