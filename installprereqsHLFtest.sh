#!/bin/bash

# Update package list and install prerequisites
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

# Install jq
sudo apt-get install -y jq

# Install Go
GO_VERSION="1.20.5"
wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.profile
source ~/.profile

# Verify installations
docker --version
jq --version
go version

# Install Hyperledger Fabric prerequisites
curl -sSL https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh | bash -s
