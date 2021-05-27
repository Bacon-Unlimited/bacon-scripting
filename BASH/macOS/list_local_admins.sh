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

# This script lists the local admins on a Mac, except root.

admin_group="admin"
has_admin="No"
result=""

# Check every user
result=$(/usr/bin/dscl . -list /Users | while read each_username
do
  if [ "${each_username}" != "root" ]; then
    member=$(/usr/bin/dsmemberutil checkmembership -U "${each_username}" -G "${admin_group}" | cut -d " " -f 3)
    if [ "$member" == "a" ]; then
      if [ "$has_admin" == "No" ]; then
        has_admin="Yes"
        echo -n ${each_username}
      else
        echo -n ", ${each_username}"
      fi
    fi
  fi
done)

echo "${result}"
