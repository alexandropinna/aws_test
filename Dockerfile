# Usar Ubuntu como imagen base
FROM ubuntu:latest

# Metadata: Quién mantiene el Dockerfile
LABEL maintainer="alexander.pinna@protonmail.com"

# Configurar variables de entorno para permitir la instalación no interactiva de paquetes
ENV DEBIAN_FRONTEND=noninteractive

# Actualizar los repositorios de paquetes e instalar utilidades básicas
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg \
    lsb-release

# Instalar Git
RUN apt-get install -y git

# Instalar Visual Studio Code
RUN wget  -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
    && install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg \
    && sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' \
    && rm -f packages.microsoft.gpg

# Instalar Maven para proyectos Java
RUN apt-get install -y maven

# Instalar PostgreSQL
RUN apt-get install -y postgresql postgresql-contrib

# Instalar Java JRE
RUN apt-get install -y default-jre

# Instalar .NET Core SDK
RUN repo_version=$(lsb_release -r -s || grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"') \
    && wget https://packages.microsoft.com/config/ubuntu/$repo_version/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && apt-get update 

# Instalar Apache y crear un archivo index.html con 'Hola Mundo'
RUN apt-get install -y apache2 \
    && echo '<h1>Hola Mundo</h1>' > /var/www/html/index.html

# Exponer puertos para Apache y PostgreSQL
EXPOSE 80 5432

# Comando para iniciar PostgreSQL y Apache al arrancar el contenedor
CMD service postgresql start && apachectl -D FOREGROUND