#!/bin/sh
#This script builds strongswan from source from a fresh ubuntu jammy 22.04 box.
# Check if the effective user ID is 0 (root)
if [ $(id -u) -ne 0 ]; then
  echo "This script requires root privileges. Please run with sudo."
  exit 1
fi

#make logging directory
mkdir logging
touch logging/logpq.txt
#install preq for making strongswan and liboqs and packet dropper
apt install pip -y
pip install scapy
apt install gcc -y
apt install libgmp3-dev -y
apt install pkg-config -y
apt install libsystemd-dev -y
apt install libssl-dev -y
apt install iproute2 iputils-ping nano wget unzip bzip2 make gcc libssl-dev cmake ninja-build -y
#install liboqs
mkdir /liboqs 
cd /liboqs 
wget https://github.com/open-quantum-safe/liboqs/archive/refs/tags/0.9.2.zip 
unzip 0.9.2.zip 
cd liboqs-0.9.2 
mkdir build && cd build 
cmake -GNinja -DOQS_USE_OPENSSL=ON -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=/usr \
                -DCMAKE_BUILD_TYPE=Release -DOQS_BUILD_ONLY_LIB=ON .. 
ninja && ninja install 
cd / && rm -R /liboqs 
#cd back to working space
cd /root/wisp-ikev2/
#make scripts runable
chmod +x configureMoon.sh
chmod +x configureSun.sh
chmod +x forwardData.sh
chmod 600 id_rsa
#get strongswan from download and unzip
unzip reliable-transport-ikev2-plugin-main.zip

rm reliable-transport-ikev2-plugin-main/src/swanctl/commands/rekey.c
cp rekey.c reliable-transport-ikev2-plugin-main/src/swanctl/commands/
cd reliable-transport-ikev2-plugin-main

chmod +x configure
#configure strongswan
./configure --enable-cmd --enable-conftest --enable-counters --enable-openssl --enable-systemd --with-systemdsystemunitdir=/lib/systemd/system --enable-acert --enable-files --enable-swanctl --disable-charon --disable-stroke --disable-scepclient --disable-ikev1 --enable-frodo --enable-oqs --enable-silent-rules --sysconfdir=/etc
#make strongswan
apt install make
#put build-essentials here (Geoff)
make
make install

exit 0


