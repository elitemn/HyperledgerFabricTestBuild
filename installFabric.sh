#!/bin/bash

# Update package list and install prerequisites
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install git -y

#Install Docker
sudo apt-get -y install docker-compose

#Add user to docker group and apply newgroup for session
sudo usermod -aG docker $(whoami)
newgrp docker

#Start Docker
sudo systemctl start docker

#Autostart Docker
sudo systemctl enable docker

# Install jq
sudo apt-get install -y jq

# Install Go
GO_VERSION="1.24.4"
wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.profile
source ~/.profile

# Verify installations
docker --version
jq --version
go version

# Install Hyperledger Fabric test network
mkdir -p $HOME/go/src/github.com/$(whoami)
cd $HOME/go/src/github.com/$(whoami)
curl -sSLO https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh && chmod +x install-fabric.shcurl -sSL https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh | bash -s
./install-fabric.sh docker samples binary
sudo reboot
