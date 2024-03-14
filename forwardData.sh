#!/bin/bash

# Variables
remote_server="100.64.4.162"
ssh_key_path="/root/wisp-ikev2/id_rsa"
directory="/root/wisp-ikev2/logging"

# Check if the directory exists
if [ ! -d "$directory" ]; then
    echo "Directory $directory does not exist."
    exit 1
fi

# Check if there are any files in the directory
if [ -z "$(ls -A "$directory")" ]; then
    echo "Directory $directory is empty."
    exit 1
fi

# Iterate over each file in the directory
for file_to_forward in "$directory"/*; do
    if [ -f "$file_to_forward" ]; then
        echo "File found: $file_to_forward. Forwarding to the server via SSH..."
        # Forward the file to the remote server using SCP over SSH
        scp -i "$ssh_key_path" "$file_to_forward" user@$remote_server:/remote/directory/ && \
        echo "File forwarded successfully: $file_to_forward. Deleting local copy..." && \
        rm -f "$file_to_forward"
    fi
done