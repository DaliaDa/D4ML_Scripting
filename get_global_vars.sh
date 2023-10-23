#!/bin/bash

# Retrieve global variables
region=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)
az_code=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

instance_name=$(aws ec2 describe-instances --query 'Reservations[0].Instances[0].Tags[?Key==`Name`].Value' --output text)
instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
account_number=$(aws sts get-caller-identity --query 'Account' --output text)

public_ip=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
private_ip=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

# Store global variables in /opt/output.txt
cat <<EOF > /opt/output.txt
Value of variable: variable name
region name: $region
AZ name: $az_code
public IP address: $public_ip
private IP address: $private_ip
name of instance: $instance_name
instance ID: $instance_id
account number: $account_number
EOF
