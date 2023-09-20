# Use Ubuntu as the base image
FROM ubuntu:latest

# Metadata: Who maintains the Dockerfile
LABEL maintainer="alexander.pinna@protonmail.com"

# Set environment variables to allow non-interactive package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the system and install Maven
RUN apt-get update && apt-get upgrade -y && apt-get install -y maven

# Copy project folders and compile the Maven project
COPY ./app/maven_project /usr/src/app/maven_project
WORKDIR /usr/src/app/maven_project
RUN mvn clean package

# Expose ports for Maven
EXPOSE 80

# Start Maven server
CMD [ "java", "-jar", "/usr/src/app/maven_project/target/helloworld-maven-1.0-SNAPSHOT-jar-with-dependencies.jar" ]
