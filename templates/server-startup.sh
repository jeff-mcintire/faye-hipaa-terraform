#!/bin/bash

# Install ssm agent to connect with SSM
apt update
apt upgrade -y

# snap install amazon-ssm-agent --classic
# snap start amazon-ssm-agent

hostnamectl set-hostname '${host}'

mkdir /usr/src/scripts
wget https://common-scripts.fayehosting.com/hosting/server_startup.sh -O /usr/src/scripts/server_startup.sh
/bin/bash /usr/src/scripts/server_startup.sh