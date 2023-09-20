# Use Ubuntu as the base image
FROM ubuntu:latest

# Metadata: Who maintains the Dockerfile
LABEL maintainer="alexander.pinna@protonmail.com"

# Set environment variables to allow non-interactive package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the system, install Java and Maven
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y default-jre && \
    apt-get install -y maven

# Copy project folders and compile the Java project
COPY ./app/java_project /usr/src/app/java_project
WORKDIR /usr/src/app/java_project

# Compile the project
RUN mvn clean package

# Expose ports for Java
EXPOSE 80

# Start Java server
CMD [ "java", "-jar", "target/java_project-1.0-SNAPSHOT-jar-with-dependencies.jar" ]
