#!/bin/bash

# Loop 1000 times
for ((i=1; i<=1000; i++)); do
    swanctl --initiate --ike host-host
    swanctl --terminate --ike host-host
done