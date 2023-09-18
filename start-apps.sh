#!/bin/bash
# This script starts multiple services, including Java, Maven, .NET, Apache, and PostgreSQL servers.

# --- Starting Individual Services ---

# Start the Java server
# Runs in the background and listens on port 81
java -jar /usr/src/app/java_project/target/java_project-1.0-SNAPSHOT-jar-with-dependencies.jar &

# Start the Maven server
# Runs in the background and listens on port 82
java -jar /usr/src/app/maven_project/target/helloworld-maven-1.0-SNAPSHOT-jar-with-dependencies.jar &

# Start the .NET application
# Runs in the background and listens on port 83
dotnet /app/dotnet_project/HelloWorld.dll &

# Start the Apache web server
# Runs in the background with the default configuration
apachectl -D FOREGROUND &

# Start the PostgreSQL database server
# Runs in the background with the default configuration
service postgresql start &

# --- Keeping the Container Running ---

# Keep the container running
# 'tail -f /dev/null' is a common way to keep a Docker container running
tail -f /dev/null
