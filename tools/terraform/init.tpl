#!/bin/bash

# Script Variables #
INIT_LOG="/home/ubuntu/init.log"

# # Terraform Inputs # #
DD_API_KEY="${dd_api_key}"
HOSTNAME="${hostname}"
FRONTEND_REPO="${frontend_repo}"
BACKEND_REPO="${backend_repo}"
ZENDESK_REPO="${zendesk_repo}"

# Script Begins
echo "Initializing the Server as $(whoami): In Progress..." > $INIT_LOG

echo "Input Variables" >> $INIT_LOG
echo "DD_API_KEY: '$DD_API_KEY'" >> $INIT_LOG
echo "HOSTNAME: '$HOSTNAME'" >> $INIT_LOG
echo "FRONTEND: '$FRONTEND_REPO'" >> $INIT_LOG
echo "BACKEND_REPO: '$BACKEND_REPO'" >> $INIT_LOG
echo "ZENDESK_REPO: '$ZENDESK_REPO'" >> $INIT_LOG

echo "Updating the server: In Progress..." >> $INIT_LOG
apt update -y
echo "Updating the server: Complete" >> $INIT_LOG

echo "Installing the Datadog Agent: In Progress..." >> $INIT_LOG
DD_API_KEY=$DD_API_KEY DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"
mv /etc/datadog-agent/datadog.yaml > /etc/datadog-agent/old_datadog.yaml
# sed "s/^# hostname: <HOSTNAME_NAME>/hostname: $HOSTNAME/" /etc/datadog-agent/datadog.yaml > /home/ubuntu/datadog.yaml
# sudo mv /home/ubuntu/datadog.yaml /etc/datadog-agent/datadog.yaml
sed "s/^# hostname: <HOSTNAME_NAME>/hostname: $HOSTNAME/" /etc/datadog-agent/datadog.yaml > /root/datadog.yaml
sudo mv /root/datadog.yaml /etc/datadog-agent/datadog.yaml
echo "Installing the Datadog Agent: Complete" >> $INIT_LOG

echo "Cloning Sandbox Components: In Progress..." >> $INIT_LOG
# mkdir /home/ubuntu/sandbox
# cd /home/ubuntu/sandbox
mkdir /root/sandbox
cd /root/sandbox
git clone $FRONTEND_REPO
git clone $BACKEND_REPO
git clone $ZENDESK_REPO
echo "Cloning Sandbox Components: Complete" >> $INIT_LOG

echo "Initializing the server: Complete" >> $INIT_LOG
