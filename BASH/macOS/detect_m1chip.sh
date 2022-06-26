#!/bin/bash
# Script to determine if macOS is Apple M1 chip
# using `uname -p` or `uname -m` won't work because the system user 
#     doesn't initialize the same user env procs that a login shell does.
#     The standard login user converts the prior commands to correct results.
#     The system user converts them to: i386 & x86_64.
#     `uname -a` returns a long string with correct M1 arm chip detection.

# First line checks for "ARM64" in return string of `uname -a`
if [[ "$(uname -a)" =~ "ARM64" ]]
then
 # Do your Arm M1 based procedures here
 echo "ARM64 present"
else
 # Do your Intel based procedures here
 echo "NO ARM"
fi
