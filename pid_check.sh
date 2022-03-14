#!/bin/bash

# Get PID and script name to be checked
process_id=$1
scriptname=$2

echo "Checking for any existing process for:" $scriptname

# Check for any processes matching the script name provided in $1 parameter
for pid in $(pidof -x $scriptname); do
    # If PID doesn't match $process_id that means this script is already running under a different PID
    if [ $pid != $process_id ]; then
        elapsed_secs=$(ps -q $pid -o etimes=)
        elapsed_time=$(date -d@"$elapsed_secs" -u +%H"h "%M"m "%S"s")
        echo "[$(date)] $scriptname: Process has already been running with PID $pid for $elapsed_time"
        exit 1
    fi
done
