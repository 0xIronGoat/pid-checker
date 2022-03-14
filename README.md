# pid-checker

This script is designed to be called by other bash scripts.  
The scripts should pass in their script name and current PID, which `pid_check.sh` will then use to check if there's an existing PID for that script name.  
If there is an existing PID matching that script name, it will check if it is a different PID from the one that called it (i.e. if it is a previous instance of the parent script running). If any PID is found that doesn't match this, then the script will exit and prevent the parent script from kicking off a duplicate run.  

### Important Note:  
This doesn't work if a script is executed with something like `bash script.sh` as that launches a `bash` process as viewed in `ps` rather than directly launching a `script.sh` process. There's probably a better way to handle this sort of check, but I don't know what that is yet, so just don't launch your scripts that way lol.

## Usage
1. Download the script with `git clone https://github.com/0xIronGoat/pid-checker.git`

2. Place the below code at the top of any scripts for which you wish to prevent concurrent runs, making sure to update the file paths `~/pid-checker/pid_check.sh` to the location where you downloaded the script in step 1 above:  
```
# Check for existence of pid_check.sh, otherwise exit this script
[ ! -f ~/pid-checker/pid_check.sh ] && exit 127

# Get name and PID of this script run
scriptname=$(basename $0)
process_id=$$

# Execute pid_check.sh with PID and name of this particular script run
~/pid-checker/pid_check.sh $process_id $scriptname

# An exit code of anything other than 0 from pid_check.sh means this script is already running under a different PID
# so this script should be prevented from running
ES1=$?
if [ $ES1 != 0 ]; then
    exit 127
fi
```

Now, when you run any script containing this code, the first run will run as normal but any runs attempted while that first instance is executing will be prevented:
![image](https://user-images.githubusercontent.com/14928858/158181149-6a972174-4993-419d-98d9-17a0b5dc5b95.png)
