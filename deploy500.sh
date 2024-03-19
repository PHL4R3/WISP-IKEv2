#!/bin/bash
#reset the counters in the host-host
count = 0
while count<500 do
    swanctl --counters --name host-host --reset
    #logic here to make sure the tranmission is successful
    #swanctl --terminate --child host-host #try this after rekey
    swanctl --rekey --ike host-host --reauth
    swanctl --counters --name host-host --all >>/root/wisp-ikev2/logging/logging.txt
    count++
done