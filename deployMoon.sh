#!/bin/bash
cd /root
git clone https://github.com/phl4r3/wisp-ikev2
cd wisp-ikev2
chmod +x ./builder.sh
./builder.sh
./configureMoon.sh
wall "Builder Complete, continue to configuration"