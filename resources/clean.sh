#!/bin/bash

# Directory to watch
DIR=~/go/myfaceapp/testdata/images/

# Infinite loop
while true; do
    # List all files in the directory sorted by modification time, oldest first
    files=$(ls -rt "$DIR")

    # Exclude the 2 most recent files and co.jpg
    files_to_keep=$(echo "$files" | tail -n 3) # 2 most recent files + co.jpg
    files_to_delete=$(echo "$files" | grep -v -e "$(echo "$files_to_keep" | tr '\n' ' ')" | tr '\n' ' ')

    # Delete the files that need to be removed
    for file in $files_to_delete; do
        if [ "$file" != "co.jpg" ]; then
            rm "$DIR$file"
        fi
    done

    # Wait for 24 seconds before running the command again
    sleep 34
done
