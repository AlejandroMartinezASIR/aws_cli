#!/bin/bash
set -x

export AWS_PAGER=""

SG_ID_LIST=$(aws ec2 describe-security-groups \
            --query "SecurityGroups[*].GroupId" \
            --output text)

for ID in $SG_ID_LIST
do
    echo "Eliminando $ID ..."
    aws ec2 delete-security-group --group-id $ID
done