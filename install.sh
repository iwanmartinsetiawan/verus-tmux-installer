#!/bin/bash
cd

pkg update -y && pkg upgrade -y
pkg install -y libjansson nano

# termux-wake-lock
echo -e 'Checking device compatibility\n'
arch=$(uname -m)

if [ "$arch" = "aarch64" ]; then
    echo "Architecture is compatible: $arch. Status: OK"
    # Prompt user for further action
    read -p "Do you want to continue anyway? (y/n): " choice
    case "$choice" in 
        [yY][eE][sS]|[yY])
        echo "Continuing the process..."
        ;;
        [nN][oO]|[nN])
        echo "Terminating the process."
        exit 1  # End the process
        ;;
        *)
        echo "Invalid input. Terminating the process."
        exit 1  # End the process
        ;;
    esac
    sleep 5

    wget https://github.com/iwanmartinsetiawan/verus-tmux-installer/archive/refs/tags/latest.zip
    unzip latest.zip
    mv verus-tmux-installer-latest ccminer

    echo "######################################################"
    echo "   Welcome to script installer ccminer termux"
    echo "   This script is used to install ccminer until it runs automatically."
    echo ""
    echo "   Created by: Iwan M Setiawan"
    echo "######################################################"
    echo ""

    # Read data from input prompt
    echo "Input wallet address:"
    echo "Input your verus wallet address"
    read wallet

    echo "Input worker name:"
    echo "This for worker name displayed on web luckpool"
    read worker

    echo "Choose mining mode :"
    echo "Input hybrid, if you want to use hybrid mode. And leave it blank if you want to use regular mode"
    read pass

    user=$wallet.$worker

    jq --arg user "$user" --arg pass "$pass" '.user = $user | .pass = $pass' data.json > temp.json && mv temp.json data.json

    echo "Generate config file succesfully"

    ./miner.sh
elif [ "$arch" = "armv7l" ]; then
    echo "Architecture is not compatible: $arch. Status: NOK"
    exit 1
    
else
    echo "Unknown architecture: $arch"
    exit 2
    
fi


