# Usar Ubuntu como imagen base
FROM ubuntu:latest

# Metadata: Quién mantiene el Dockerfile
LABEL maintainer="alexander.pinna@protonmail.com"

# Configurar variables de entorno para permitir la instalación no interactiva de paquetes
ENV DEBIAN_FRONTEND=noninteractive

# ---- Fase de Instalación de Dependencias ----

# Actualizar el sistema y descargar utilidades básicas
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    wget \
    curl \
    gnupg \
    lsb-release \
    git \
    maven \
    postgresql postgresql-contrib \
    default-jre \
    apache2

# Instalar Visual Studio Code
RUN wget  -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
    && install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg \
    && sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' \
    && rm -f packages.microsoft.gpg \
    && apt-get update \
    && apt-get install -y code

# Instalar .NET Core SDK
RUN repo_version=$(lsb_release -r -s || grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"') \
    && wget https://packages.microsoft.com/config/ubuntu/$repo_version/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y dotnet-sdk-6.0

# Verificar la instalación de .NET
# RUN dotnet --info

# ---- Fase de Configuración ----

# Copiar el script de inicio y dar permisos de ejecución
COPY ./start-apps.sh /usr/src/app/start-apps.sh
RUN chmod +x /usr/src/app/start-apps.sh

# Copiar las carpetas de proyectos
COPY ./app /usr/src/app

# Compilar el proyecto Java
WORKDIR /usr/src/app/java_project
RUN mvn clean package

# Compilar el proyecto Maven
WORKDIR /usr/src/app/maven_project
RUN mvn clean package

# Compilar la aplicación .NET
WORKDIR /usr/src/app/dotnet_project
# RUN dotnet build -c Release

# Cambiar al directorio de trabajo original
WORKDIR /usr/src/app

# ---- Fase de Exposición de Puertos ----

# Exponer puertos para Apache, PostgreSQL, Java, Maven y .NET
EXPOSE 80 5432 81 82 83

# ---- Fase de Comando de Inicio ----

# Comando para iniciar PostgreSQL, Apache y ejecutar el script
CMD service postgresql start && apachectl -D FOREGROUND && ./start-apps.sh
