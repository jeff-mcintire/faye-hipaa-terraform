#!/bin/bash

snap install aws-cli --classic
hostnamectl set-hostname '${host}.faye'
mkdir /usr/src/scripts
aws s3 sync s3://faye-hipaa-user-data/ /usr/src/scripts/
/bin/bash /usr/src/scripts/init_script.sh
