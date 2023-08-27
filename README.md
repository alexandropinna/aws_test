# Proyecto de Infraestructura como Código y Despliegue Continuo para Prueba Técnica Arroyo Consulting

## Descripción

Este proyecto está diseñado como una solución integral para desplegar aplicaciones modernas en la nube. Utiliza Terraform para automatizar la creación y gestión de recursos en AWS, incluyendo EC2 para la computación, RDS para bases de datos y ECS para la orquestación de contenedores.

### ¿Por qué EC2, ECS y RDS?

- **EC2 (Elastic Compute Cloud)**: Se utiliza para demostrar la capacidad de conectividad a bases de datos, en este caso, RDS. EC2 nos ofrece flexibilidad y control completo sobre nuestros recursos computacionales, lo que lo convierte en la elección ideal para alojar nuestra aplicación y establecer una conexión segura con la base de datos RDS.

- **ECS (Elastic Container Service)**: Este servicio se utiliza para demostrar que el Pipeline de CI/CD, creado utilizando GitHub Actions, funciona como se espera. ECS permite ejecutar aplicaciones en contenedores de una manera altamente escalable y de alto rendimiento, lo cual es especialmente útil para aplicaciones con arquitecturas de microservicios.

- **RDS (Relational Database Service)**: Ofrece bases de datos relacionales que son fáciles de configurar, operar y escalar. RDS se utiliza aquí como el back-end de datos para nuestra aplicación y es accesible desde la instancia EC2.

Estas herramientas no solo son robustas, sino que también son altamente compatibles entre sí, lo que hace que la integración sea fluida y eficiente.

![Arquitectura del Proyecto](url-de-la-imagen-de-arquitectura)

## Índice

- [Requisitos](#requisitos)
- [Configuración de AWS](#configuración-de-aws)
- [Configuración de GitHub Actions](#configuración-de-github-actions)
- [Terraform](#terraform)
- [Docker](#docker)
- [Uso](#uso)
- [Contribuir](#contribuir)

## Requisitos

- Terraform
- AWS CLI
- Docker
- GitHub

## Configuración de AWS

El proyecto crea varios recursos en AWS, que se detallan en las siguientes secciones.

## Configuración de GitHub Actions

El archivo `.github/workflows/cicd.yml` configura un flujo de trabajo de GitHub Actions para la construcción y despliegue.

## Terraform

La infraestructura como código se maneja mediante archivos de Terraform.

### Variables de Terraform

Las variables se definen en `variables.tf`.

### Salidas de Terraform

Las salidas están definidas en `outputs.tf`.

## Docker

El `Dockerfile` en este proyecto está configurado para crear una imagen Docker que sirve como un entorno de desarrollo completo. Esta imagen está basada en Ubuntu y viene preconfigurada con una serie de herramientas y servicios que facilitan el desarrollo y la implementación de aplicaciones.

#### Lo que hace el Dockerfile:

1. **Utiliza Ubuntu como imagen base**: Este es el sistema operativo en el que se instalarán todas las herramientas y servicios.

2. **Instala Utilidades Básicas**: Incluye herramientas como `wget`, `curl`, `gnupg`, y `lsb-release` para facilitar la descarga e instalación de paquetes adicionales.

3. **Instala Git**: Una herramienta esencial para el control de versiones.

4. **Instala Visual Studio Code**: Un editor de código fuente ampliamente utilizado, que será útil para el desarrollo.

5. **Instala Maven**: Herramienta de gestión de proyectos y comprensión de software, especialmente útil para proyectos Java.

6. **Instala PostgreSQL y su contribución**: Una base de datos relacional de código abierto que se utilizará como el sistema de almacenamiento de datos.

7. **Instala Java JRE**: El entorno de ejecución de Java, necesario para ejecutar aplicaciones Java.

8. **Instala .NET Core SDK**: El SDK de .NET Core permitirá la compilación y ejecución de proyectos .NET Core.

9. **Instala Apache y muestra un "Hola Mundo"**: Un servidor web Apache se instala y se configura con una página de inicio que muestra "Hola Mundo".

10. **Expone puertos 80 y 5432**: El puerto 80 se expone para el servidor web Apache y el puerto 5432 para PostgreSQL.

11. **Inicia PostgreSQL y Apache**: Al arrancar el contenedor, se inician automáticamente el servidor web Apache y el servicio de base de datos PostgreSQL.

#### Resultados:

- Se montará la imagen de Docker creada en el servicio de cómputo seleccionado.
- Podrás usar Git para control de versiones.
- Podrás editar código con Visual Studio Code.
- Podrás gestionar proyectos Java con Maven.
- Tendrás una base de datos PostgreSQL lista para usar.
- Podrás ejecutar aplicaciones Java gracias al Java JRE instalado.
- Podrás compilar y ejecutar proyectos .NET Core.
- Tendrás un servidor Apache funcionando con una página de inicio que muestra "Hola Mundo".

Esta imagen de Docker es una solución integral para los desarrolladores, eliminando la necesidad de instalar y configurar múltiples herramientas y servicios manualmente.

## Uso

Siga estos pasos para implementar la solución:

1. Clona este repositorio.
2. Configura tus credenciales de AWS.
3. Ejecuta `terraform init` y `terraform apply`.
4. Haz un push al repositorio para desencadenar el flujo de trabajo de GitHub Actions.

## Autor

- Alejandro Piña ([correo electrónico](mailto:alexander.pinna@protonmail.com))