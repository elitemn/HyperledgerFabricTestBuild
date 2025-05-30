#!/bin/bash

# Update and install prerequisites
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y git curl docker.io docker-compose jq

# Get the username from the script arguments

PRINCIPAL_ID=$1

# Add the user to the Docker group
sudo usermod -aG docker $PRINCIPAL_ID

#Create a new session
su $PRINCIPAL_ID

#TS custom logging
echo "Managed Identity Principal ID: $PRINCIPAL_ID" > ~./HLUserlog.txt
echo "PWD: $PWD" >> ~./HLUserlog.txt
echo "CurrentUser:" >> ~./HLUserlog.txt & whoami >> ~./HLUserlog.txt

# Install Go
GO_VERSION="1.24.3"
wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile
source ~/.profile

echo "CurrentPath: $PATH" >> ~./HLUserlog.txt & whoami >> ~./HLUserlog.txt

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Install Hyperledger Fabric binaries
#curl -sSL https://bit.ly/2ysbOFE | bash -s
mkdir -p $HOME/go/src/github.com/$PRINCIPAL_ID
cd $HOME/go/src/github.com/$PRINCIPAL_ID
curl -sSLO https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh && chmod +x install-fabric.sh

./install-fabric.sh d s b

# Clone Hyperledger Fabric samples
git clone https://github.com/hyperledger/fabric-samples.git
cd fabric-samples/test-network

# Start the test network
./network.sh up createChannel -c mychannel -ca
