#!/bin/bash
# My First Commitauto trigger 
PH=$(curl -sL http://169.254.169.254/latest/meta-data/public-hostname)
PIP=$(curl -sL http://169.254.169.254/latest/meta-data/public-ipv4)
sg=$(curl -sL http://169.254.169.254/latest/meta-data/security-groups)
Ins=$(curl -sL http://169.254.169.254/latest/meta-data/instance-id)
InsType=$(curl -sL http://169.254.169.254/latest/meta-data/instance-type)
echo "==================================="
echo "public host name is : $PH"
echo "Public ip is :$PIP"
echo "Security group $sg"
echo "Instance id is $Ins"
echo "Instance type is $InsType"
