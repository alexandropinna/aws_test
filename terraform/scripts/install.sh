#!/bin/bash             
echo "Este es un mensaje" > ~/mensaje.txt

# Ejecutar un contenedor usando la imagen
docker run --name arroyo-prueba-tec -p 80:80 -p 5432:5432 alex919090/arroyo-prueba-tec:latest 