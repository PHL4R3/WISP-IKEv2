#!/bin/sh
#This script builds strongswan from source from a fresh ubuntu jammy 22.04 box.
# Check if the effective user ID is 0 (root)
if [ $(id -u) -ne 0 ]; then
  echo "This script requires root privileges. Please run with sudo."
  exit 1
fi
#update and upgrade packages
apt update
apt upgrade -y
#get strongswan from download and unzip
wget https://download.strongswan.org/strongswan-5.9.0.tar.bz2 
tar -jxvf strongswan-5.9.0.tar.bz2
while [! -f "strongswan-5.9.0"]; do
    echo "waiting for tar to unzip"
    sleep 1
cd strongswan-5.9.0

#configure strongswan
./configure --prefix=/usr/ --sysconfdir=/etc --enable-counters
#install preq for making strongswan
apt install gcc -y
apt install libgmp3-dev -y
#make strongswan
apt install make
make
make install

exit 0


