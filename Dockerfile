# Use Ubuntu as the base image
FROM ubuntu:latest

# Metadata: Who maintains the Dockerfile
LABEL maintainer="alexander.pinna@protonmail.com"

# Set environment variables to allow non-interactive package installation
ENV DEBIAN_FRONTEND=noninteractive

# ---- Dependency Installation Phase ----

# Update the system and download basic utilities
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

# Install Visual Studio Code
RUN wget  -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
    && install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg \
    && sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' \
    && rm -f packages.microsoft.gpg \
    && apt-get update \
    && apt-get install -y code

# Install apt-transport-https and add priority pin
RUN apt-get install -y apt-transport-https && \
    echo 'Package: *\nPin: origin "packages.microsoft.com"\nPin-Priority: 1001' > /etc/apt/preferences.d/99microsoft-dotnet.pref

# Install .NET Core SDK
RUN apt-get update && \
    apt-get install -y dotnet-sdk-6.0

# Verify .NET installation
RUN dotnet --info

# ---- Configuration Phase ----

# Install Apache and create an index.html file with 'Hello World'
RUN apt-get install -y apache2 \
    && echo '<h1>Hola Mundo Apache</h1>' > /var/www/html/index.html

# Copy the startup script and give it execute permissions
COPY ./start-apps.sh /usr/src/app/start-apps.sh
RUN chmod +x /usr/src/app/start-apps.sh

# Copy project folders
COPY ./app /usr/src/app

# Compile the Java project
WORKDIR /usr/src/app/java_project
RUN mvn clean package

# Compile the Maven project
WORKDIR /usr/src/app/maven_project
RUN mvn clean package

# Compile the .NET application
WORKDIR /usr/src/app/dotnet_project
RUN dotnet publish -c Release -o /app/dotnet_project

# Switch to the original working directory
WORKDIR /usr/src/app

# ---- Ports Exposure Phase ----

# Expose ports for Apache, PostgreSQL, Java, Maven, and .NET
EXPOSE 80 5432 81 82 83

# ---- Startup Command Phase ----

# Command to start PostgreSQL, Apache, and run the script
CMD [ "/bin/sh", "-c", "/usr/src/app/start-apps.sh" ]
