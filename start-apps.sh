# Iniciar el servidor Java en el puerto 81
java -jar /usr/src/app/java_project/target/helloworld-1.0-SNAPSHOT.jar &

# Iniciar el servidor Maven en el puerto 82
java -jar /usr/src/app/maven_project/target/helloworld-maven-1.0-SNAPSHOT-jar-with-dependencies.jar &

# Iniciar la aplicación .NET en el puerto 83
dotnet /app/dotnet_project/HelloWorld.dll &

apachectl -D FOREGROUND &

service postgresql start

# Mantener el contenedor en ejecución
tail -f /dev/null
