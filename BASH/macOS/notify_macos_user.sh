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

# This displays a dialog box to notify the user.  Can be used for multiple purposes.
# This example shows a reminder to reboot.

osascript -e 'display alert "Please Reboot" message "IT has installed updates.\nPlease reboot your computer as soon as possible." as critical buttons {"OK"} default button 1' >/dev/null 2>&1 &
