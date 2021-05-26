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

# This shows usage of a salt-call command to run a single Bacon state.
# Bacon states are referenced using the following scheme:
#
# bacon.states.{state_platform}.{slugify(state_name)}_{state_id}
#
# where state_platform is the Platform (OS) the state was created for,
# state_name is a slugified version of the state name 
# (slugified as per these rules https://docs.djangoproject.com/en/3.2/ref/utils/#django.utils.text.slugify),
# and state_id is the numeric ID for the state (can be found at the end of the URL when viewing the state).
# The first example below shows how you would reference a Windows state called "Install Chrome" with an id of 20.

# If you want a script that only ever applies a single state, you can use
# this example:
salt-call state.apply bacon.states.Windows.install-chrome_20

# If you want to specify which state to apply when executing the script,
# you could use one of these two alternatives instead:

# Alternative method to accept a command line argument for the state name
# salt-call state.apply $1

# Alternative method to accept a template variable for the state name
# salt-call state.apply {{state}}
