#!/bin/bash
#update and upgrade packages
apt update
apt upgrade -y
cd /root
git clone -b tcp_decouple https://github.com/PHL4R3/WISP-IKEv2
cd WISP-IKEv2
chmod +x ./builder.sh
./builder.sh
./configureMoon.sh
