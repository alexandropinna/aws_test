#!/bin/bash
# Este script inicia varios servicios, incluidos servidores Java, Maven, .NET, Apache y PostgreSQL.

# --- Inicio de Servicios Individuales ---

# Iniciar el servidor Java
# Se ejecuta en segundo plano y escucha en el puerto 81
java -jar /usr/src/app/java_project/target/helloworld-1.0-SNAPSHOT.jar &

# Iniciar el servidor Maven
# Se ejecuta en segundo plano y escucha en el puerto 82
java -jar /usr/src/app/maven_project/target/helloworld-maven-1.0-SNAPSHOT-jar-with-dependencies.jar &

# Iniciar la aplicación .NET
# Se ejecuta en segundo plano y escucha en el puerto 83
dotnet /app/dotnet_project/HelloWorld.dll &

# Iniciar el servidor web Apache
# Se ejecuta en segundo plano con la configuración predeterminada
apachectl -D FOREGROUND &

# Iniciar el servidor de base de datos PostgreSQL
# Se ejecuta en segundo plano con la configuración predeterminada
service postgresql start &

# --- Mantener el Contenedor en Ejecución ---

# Mantener el contenedor en ejecución
# 'tail -f /dev/null' es una forma común de mantener un contenedor Docker en ejecución
tail -f /dev/null
