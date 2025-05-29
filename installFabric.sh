#!/bin/bash
# Update and install prerequisites
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y git curl docker.io docker-compose jq

# Install Go
GO_VERSION="1.20.3"
wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile
source ~/.profile

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Install Hyperledger Fabric binaries
curl -sSL https://bit.ly/2ysbOFE | bash -s
# Clone Hyperledger Fabric samples
git clone https://github.com/hyperledger/fabric-samples.git
cd fabric-samples/test-network

# Start the test network
./network.sh up createChannel -c mychannel -ca
