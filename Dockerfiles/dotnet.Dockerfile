# Use Ubuntu as the base image
FROM ubuntu:latest

# Metadata: Who maintains the Dockerfile
LABEL maintainer="alexander.pinna@protonmail.com"

# Set environment variables to allow non-interactive package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install .NET Core SDK
RUN apt-get update && apt-get install -y wget apt-transport-https gnupg \
    && wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
    && apt-key add packages.microsoft.gpg \
    && apt-get install -y dotnet-sdk-6.0

# Copy project folders and compile the .NET application
COPY ./app/dotnet_project /usr/src/app/dotnet_project
WORKDIR /usr/src/app/dotnet_project
RUN dotnet publish -c Release -o /app/dotnet_project

# Expose ports for .NET
EXPOSE 80

# Start .NET application
CMD [ "dotnet", "/app/dotnet_project/HelloWorld.dll" ]
