#!/bin/bash

# Loop 500 times
for ((i=1; i<=500; i++)); do
    swanctl --rekey --ike host-host --reauth
done