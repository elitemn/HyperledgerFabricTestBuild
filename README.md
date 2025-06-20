This repostory consists of an Azure ARM template that will create a Linux VM (Umbuntu 22.04) and the a script will 
1. Install Hyperledger Prereqs, (go, jq, docker compose)
2. Download and install the Hyperledger Fabric test network in a lab environment

Fist deploy the VM using the ARM template
Then login to the newly created VM, download the InstallFabric.sh using the following command:
wget -qO- "https://raw.githubusercontent.com/elitemn/HyperledgerFabricTestBuild/refs/heads/main/installFabric.sh" | tr -d '\r' > installFabric.sh & chmod +x installFabric.sh

then run the downloaded script:
./installFabric.sh

After the script finishes and the VM is restarted, install is complete.
