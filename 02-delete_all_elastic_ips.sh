#!/bin/bash
set -x

export AWS_PAGER=""

ELASTIC_IP_IDS=$(aws ec2 describe-addresses \
             --query Addresses[*].AllocationId \
             --output text)

for ID in $ELASTIC_IP_IDS
do
    echo "Eliminando $ID ..."
    aws ec2 release-address --allocation-id $ID
done