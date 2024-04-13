#!/bin/bash
#update and upgrade packages
apt update
apt upgrade -y
cd /root
git clone -b tcp_decouple https://github.com/PHL4R3/WISP-IKEv2/tree/tcp_decouple
cd wisp-ikev2
chmod +x ./builder.sh
./builder.sh
./configureMoon.sh
