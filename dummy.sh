#!/bin/bash

# Check for existence of pid_check.sh, otherwise exit this script
[ ! -f ~/BashProjects/pid_check.sh ] && exit 127

# Get name and PID of this script run
scriptname=$(basename $0)
process_id=$$

# Execute pid_check.sh with PID and name of this particular script run
~/BashProjects/pid_check.sh $process_id $scriptname

# An exit code of anything other than 0 from pid_check.sh means this script is already running under a different PID
# so this script should be prevented from running
ES1=$?
if [ $ES1 != 0 ]; then
    exit 127
fi

# Execute dummy code
sleep 120
