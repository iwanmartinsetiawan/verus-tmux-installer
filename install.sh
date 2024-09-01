#!/bin/bash
cd

pkg update -y && pkg upgrade -y
pkg install -y libjansson wget nano

termux-wake-lock

wget https://github.com/iwanmartinsetiawan/verus-tmux-installer/archive/refs/tags/latest.zip
unzip latest.zip
mv verus-tmux-installer-latest ccminer

echo "######################################################"
echo "   Welcome to Script Installer ccminer Termux"
echo "   Script ini digunakan untuk mengupdate informasi user"
echo "   dan password pada file JSON untuk pool mining."
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
