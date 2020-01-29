#!/bin/bash

# Add GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Add Repo
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# Update local repo list 
sudo apt-get update
# Install
sudo apt-get install -y docker-ce
# Give user docker access
sudo usermod -aG docker vagrant

# Enable Docker API
sudo mkdir /etc/systemd/system/docker.service.d/
echo "[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:4243" > \
  /etc/systemd/system/docker.service.d/startup_options.conf

# Reload Unit files
sudo systemctl daemon-reload
# Start Docker
sudo systemctl restart docker
# Display docker version
docker version
