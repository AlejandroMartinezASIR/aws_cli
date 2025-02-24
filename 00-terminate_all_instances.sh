#!/bin/bash
set -x

export AWS_PAGER=""

EC2_ID_LIST=$(aws ec2 describe-instances \
                --filters "Name=instance-state-name,Values=running" \
                --query "Reservations[*].Instances[*].InstanceId" \
                --output text)

aws ec2 terminate-instances \
    --instance-ids $EC2_ID_LIST