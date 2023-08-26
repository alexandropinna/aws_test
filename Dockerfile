# Usar una imagen base de Ubuntu
FROM ubuntu:latest

# Metadata como el mantenedor del Dockerfile
LABEL maintainer="your-email@example.com"

# Configurar variables de entorno para instalaciones no interactivas
ENV DEBIAN_FRONTEND=noninteractive

# Actualizar e instalar utilidades necesarias
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg \
    lsb-release

# Instalar Git
RUN apt-get install -y git

# # Instalar Visual Studio Code
RUN wget  -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
    && install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg \
    && sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' \
    && rm -f packages.microsoft.gpg

# Instalar Maven
RUN apt-get install -y maven

# Instalar PostgreSQL
RUN apt-get install -y postgresql postgresql-contrib

# Instalar Java JRE
RUN apt-get install -y default-jre

# Instalar .NET Core SDK para proyectos NetCore
RUN repo_version=$(lsb_release -r -s || grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"') \
    && wget https://packages.microsoft.com/config/ubuntu/$repo_version/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && apt-get update 

# Instalar Apache y poner un Hola Mundo
RUN apt-get install -y apache2 \
    && echo '<h1>Hola Mundo</h1>' > /var/www/html/index.html

# Exponer puertos necesarios
EXPOSE 80 5432

# Comando para iniciar Apache y mantener el contenedor en funcionamiento
CMD service postgresql start && apachectl -D FOREGROUND
