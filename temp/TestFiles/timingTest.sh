#!/bin/bash
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
currentdate=`date +"%Y-%m-%d %T"`
echo $currentdate >> /home/gwatts/Test/test01.txt &
apt update >> /home/gwatts/Test/test01.txt & 
wait 
currentdate=`date +"%Y-%m-%d %T"`
echo $currentdate >> /home/gwatts/Test/test01.txt &
