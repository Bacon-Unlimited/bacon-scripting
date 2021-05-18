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

# This shows usage of a salt-call command to list the current user's home directory
# based on the user who was logged in when Bacon last updated the current user.

# The double curly braces are an example of using Jinja to substitute in information
# from Bacon - in this case the current user as listed in the bacon_user grain.  
# cmd.run requires an additional parameter to denote the templating engine 
# you're using in the command, which is why we add template=jinja to the end of the line.

salt-call cmd.run "ls -lah /Users/{{ salt['grains.get']('bacon_user:current_user', '') }}" template=jinja
