#!/bin/bash
# Read Password
# echo -n Password: 
# read -s password
# echo
# Run Command
# echo $password
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
# apt update -y
source /home/gwatts/Temp/install.sh
