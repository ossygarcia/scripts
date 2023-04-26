#!/bin/bash

# List all open files
lsof | while read -r line
do
  # Extract the filename and process ID
  file=$(echo "$line" | awk '{print $9}')
  pid=$(echo "$line" | awk '{print $2}')

  # Check if the file is open by a user and not a system process
  if [ "$(ps -p "$pid" -o comm=)" != "systemd" ]
  then
    # If the file is not in use, close it
    if [ ! -f "$file" ]
    then
      kill -9 "$pid"
      echo "Closed file $file with PID $pid"
    fi
  fi
done
