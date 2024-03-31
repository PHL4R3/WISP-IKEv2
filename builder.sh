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
#make scripts runable
chmod +x configureMoon.sh
chmod +x configureSun.sh
chmod +x forwardData.sh
chmod 600 id_rsa
#get strongswan from download and unzip
wget https://download.strongswan.org/strongswan-6.0.0beta6.tar.bz2
tar -jxvf strongswan-6.0.0beta6.tar.bz2
while [! -d "strongswan-6.0.0beta6"]; do
    echo "waiting for tar to unzip"
    sleep 1
done
rm strongswan-6.0.0beta6/src/swanctl/commands/rekey.c
cp rekey.c /root/wisp-ikev2/strongswan-6.0.0beta6/src/swanctl/commands/
cd strongswan-6.0.0beta6

#install preq for making strongswan
apt install gcc -y
apt install libgmp3-dev -y
apt install pkg-config -y
apt install libsystemd-dev -y
apt install libcrypto -y
apt install libssl-dev -y
#configure strongswan
./configure --enable-cmd --enable-conftest --enable-counters --enable-openssl --enable-systemd --with-systemdsystemunitdir=/lib/systemd/system --enable-acert --enable-files --enable-swanctl --disable-charon --disable-stroke --disable-scepclient --disable-ikev1 --enable-frodo --enable-oqs --enable-silent-rules --sysconfdir=/etc
#make strongswan
apt install make
#put build-essentials here (Geoff)
make
make install

exit 0


