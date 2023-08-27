# Bloque de variables locales
# Utilizado para definir variables que son locales a este archivo de configuración.
locals {
  # Sufijo que se compone de las etiquetas del proyecto, entorno y región
  # Se utilizará para nombrar recursos de manera coherente en todo el proyecto
  sufix = "${var.tags.project}-${var.tags.env}-${var.tags.region}"
}