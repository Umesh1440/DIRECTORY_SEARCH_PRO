#!/bin/bash

echo "###########################################################"
echo "##                                                       ##"
echo "##            DIRECTORY SEARCH PRO - SETUP SCRIPT        ##"
echo "##                                                       ##"
echo "###########################################################"
echo "##                Made by Umesh Sharma                   ##"
echo "###########################################################"
echo ""

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to install Go
install_go() {
    echo "[+] Installing Go..."
    wget https://go.dev/dl/go1.21.1.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.21.1.linux-amd64.tar.gz
    rm go1.21.1.linux-amd64.tar.gz

    # Add Go to PATH
    export PATH=$PATH:/usr/local/go/bin
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc

    echo "[+] Go installed successfully!"
}

# Check and install Go if not installed
if ! command_exists go; then
    install_go
else
    echo "[+] Go is already installed."
fi

# Install subfinder, assetfinder, golang, and xterm using apt
echo "[+] Installing subfinder, assetfinder, golang, and xterm..."
sudo apt update
sudo apt install -y xterm subfinder assetfinder golang
echo "[+] subfinder, assetfinder, golang, and xterm installed successfully!"

# Function to install httpx
install_httpx() {
    echo "[+] Installing httpx..."
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
    echo "[+] httpx installed successfully!"
}

# Check and install httpx if not installed
if ! command_exists httpx; then
    install_httpx
else
    echo "[+] httpx is already installed."
fi

# Function to install dirsearch
install_dirsearch() {
    echo "[+] Installing dirsearch..."
    git clone https://github.com/maurosoria/dirsearch.git --depth 1
    cd dirsearch || exit
    pip3 install -r requirements.txt
    # Add dirsearch to PATH by creating a symbolic link to dirsearch.py in /usr/local/bin
    sudo ln -sf "$(pwd)/dirsearch.py" /usr/local/bin/dirsearch
    cd ..
    echo "[+] dirsearch installed successfully!"
}

# Check and install dirsearch if not installed
if ! command_exists dirsearch; then
    install_dirsearch
else
    echo "[+] dirsearch is already installed."
fi

echo ""
echo "[+] All tools have been installed successfully! You can now run the Directory Search Pro script."
