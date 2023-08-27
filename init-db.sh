#!/bin/bash

# Comandos para conectarse al RDS y crear la base de datos
#psql -h $RDS_ENDPOINT -U $RDS_USERNAME -d $RDS_DBNAME -c "CREATE DATABASE testing_db_ecs;"
# psql "host=$DB_HOST port=$DB_PORT dbname=postgres user=$DB_USER password=$DB_PASS" -c "CREATE DATABASE testing_db_ecs;"

psql "host=terraform-20230826235006805200000003.cbsvfiw8swkk.us-east-1.rds.amazonaws.com port=5432 dbname=postgres user=my_db_user password=DXR4dHphensTn4ct -c "CREATE DATABASE testing_db_ecs;"