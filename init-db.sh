#!/bin/bash

# Comandos para conectarse al RDS y crear la base de datos
psql -h $RDS_ENDPOINT -U $RDS_USERNAME -d $RDS_DBNAME -c "CREATE DATABASE testing_db_ecs;"
