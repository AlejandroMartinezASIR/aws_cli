#!/bin/bash
set -x

# Deshabilitamos la paginación de la salida de los comandos de AWS CLI
export AWS_PAGER=""

#Leemos las variables de entorno
source .env

#Obtenemos la ID de la instancia a partir de su nombre
INSTANCE_ID=$(aws ec2 describe-instances \
            --filters "Name=tag:Name,Values=$INSTANCE_NAME_BALANCEADOR" \
                      "Name=instance-state-name,Values=running" \
            --query "Reservations[*].Instances[*].InstanceId" \
            --output text)

#Creamos la IP elastica
ELASTIC_IP=$(aws ec2 allocate-address --query PublicIp --output text)

#Asociamos la IP para la instancia del balanceador de carga
aws ec2 associate-address --instance-id $INSTANCE_ID --public-ip $ELASTIC_IP