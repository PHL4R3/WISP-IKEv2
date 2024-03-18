#!/bin/sh
#This script builds strongswan from source from a fresh ubuntu jammy 22.04 box.
# Check if the effective user ID is 0 (root)
if [ $(id -u) -ne 0 ]; then
  echo "This script requires root privileges. Please run with sudo."
  exit 1
fi

#make logging directory
mkdir logging
#make scripts runable
chmod +x configureMoon.sh
chmod +x configureSun.sh
chmod +x forwardData.sh
chmod 600 id_rsa
#get strongswan from download and unzip
wget https://download.strongswan.org/strongswan-5.9.0.tar.bz2 
tar -jxvf strongswan-5.9.0.tar.bz2
while [! -d "strongswan-5.9.0"]; do
    echo "waiting for tar to unzip"
    sleep 1
done
cd strongswan-5.9.0

#install preq for making strongswan
apt install gcc -y
apt install libgmp3-dev -y
apt install pkg-config -y
apt install libsystemd-dev
#configure strongswan
./configure --prefix=/usr --sysconfdir=/etc --enable-systemd --enable-swanctl --with-systemdsystemunitdir=/lib/systemd/system --enable-acert --enable-counters --enable-files --disable-charon --disable-stroke --disable-scepclient
#make strongswan
apt install make
#put build-essentials here (Geoff)
make
make install

exit 0


