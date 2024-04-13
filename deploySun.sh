#!/bin/bash
#update and upgrade packages
apt update
apt upgrade -y
cd /root
git clone -b tcp_encap https://github.com/phl4r3/wisp-ikev2
cd wisp-ikev2
chmod +x ./builder.sh
./builder.sh
./configureSun.sh