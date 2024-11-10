#!/bin/bash
# Install ssm agent to connect with SSM
apt update -y
apt upgrade -y

# snap install amazon-ssm-agent --classic
# snap start amazon-ssm-agent

hostnamectl set-hostname '${host}'
curl --tlsv1.2 --silent --show-error --header 'x-connect-key: 504692c1583ee5c6f17d83b48ddecd2f512f8c02' https://kickstart.jumpcloud.com/Kickstart | sudo bash
bash -c "curl -s --ssl-no-revoke https://www.todyl.com/tools/v2/DebianInstall.sh | sudo bash -s -- RCp6cDjYsdVDvCWtKVciju9iDbtw5zfRaBa0089RPZfVgVPtuF2oFfWpHM14AE7L Latest" 