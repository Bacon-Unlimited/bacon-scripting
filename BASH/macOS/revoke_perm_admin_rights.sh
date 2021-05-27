#!/usr/bin/env bash

################################################################################
#  
#  Bacon Unlimited
#  __________________
#  
#   [2018] - [2021] Bacon Unlimited 
#   All Rights Reserved.
#  
#  NOTICE:  All information contained herein is, andins
#  the property of Bacon Unlimited and its suppliers,
#  if any.  The intellectual and technical concepts contained
#  herein are proprietary to Bacon Unlimited
#  and its suppliers and may be covered by U.S. and Foreign Patents,
#  patents in process, and are protected by trade secret or copyright law.
#  Dissemination of this information or reproduction of this material
#  is strictly forbidden unless prior written permission is obtained
#  from Bacon Unlimited.
################################################################################

# This script permanently revokes admin rights from a user on a Mac.
# It accepts a username as a script template variable at execution time.

username="{{ username_to_revoke }}"

if [[ -z "${username}" ]]; then
    echo "ERROR: You must pass a username to revoke admin rights from."
    exit 1
fi

dseditgroup -o edit -d "${username}" -t user admin
if [ "$?" == "0" ]; then #error checking
     echo "Successfully removed $username from admin group"
else
     echo "ERROR - There was a problem with removing $username from admin group."
fi
