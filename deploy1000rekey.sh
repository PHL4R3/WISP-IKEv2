#!/bin/bash

# Loop 1000 times
for ((i=1; i<=1000; i++)); do
    swanctl --rekey --child host --reauth
done