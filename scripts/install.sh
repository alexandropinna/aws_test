#!/bin/bash             
# Construir la imagen Docker
docker build -t mi_contenedor -f ../Dockerfile

# Ejecutar un contenedor usando la imagen
docker run -p 80:80 -p 5432:5432 mi_contenedor