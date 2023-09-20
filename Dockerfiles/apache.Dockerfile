# Use Ubuntu as the base image
FROM ubuntu:latest

# Metadata: Who maintains the Dockerfile
LABEL maintainer="alexander.pinna@protonmail.com"

# Set environment variables to allow non-interactive package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the system and download Apache
RUN apt-get update && apt-get upgrade -y && apt-get install -y apache2

# Install Apache and create an index.html file with 'Hello World'
RUN echo '<h1>Hola Mundo Apache</h1>' > /var/www/html/index.html

# Expose ports for Apache
EXPOSE 80

# Start Apache web server
CMD [ "apachectl", "-D", "FOREGROUND" ]
