#and edit file permissions to allow execution, wihtout the need to install a conversion utility. Fixes issue #5.sh
#wget -qO- "https://raw.githubusercontent.com/elitemn/HyperledgerFabricTestBuild/refs/heads/main/installFabric.sh" | tr -d '\r' > installFabric.sh & chmod +x installFabric.sh

# Update package list and install prerequisites
#sudo -s
export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a
sudo -E apt-get update -y
sudo -E apt-get upgrade -y
sudo -E apt-get -y dist-upgrade

#Install Docker
sudo -E apt-get -y install docker-compose

# Install jq
sudo -E apt-get install -y jq


#Add user to docker group and apply newgroup for session
sudo usermod -aG docker $(whoami)
#newgrp docker

#Start Docker
sudo systemctl start docker

#Autostart Docker
sudo systemctl enable docker

# Install Go
GO_VERSION="1.24.4"
wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.profile
source ~/.profile

# Verify installations
docker --version >> versions.txt
jq --version >> versions.txt
go version >> versions.txt

# Install Hyperledger Fabric test network
mkdir -p $HOME/go/src/github.com/$(whoami)
cd $HOME/go/src/github.com/$(whoami)
curl -sSLO https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh && chmod +x install-fabric.sh
./install-fabric.sh docker samples binary
sudo reboot
