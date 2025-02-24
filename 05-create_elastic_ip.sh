#!/bin/bash
set -x

export AWS_PAGER=""

source .env

INSTANCE_ID=$(aws ec2 describe-instances \
            --filters "Name=tag:Name,Values=$INSTANCE_NAME_FRONTEND" \
                      "Name=instance-state-name,Values=running" \
            --query "Reservations[*].Instances[*].InstanceId" \
            --output text)

ELASTIC_IP=$(aws ec2 allocate-address --query PublicIp --output text)

aws ec2 associate-address --instance-id $INSTANCE_ID --public-ip $ELASTIC_IP