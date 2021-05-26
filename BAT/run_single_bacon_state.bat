@REM ################################################################################
@REM #  
@REM #  Bacon Unlimited
@REM #  __________________
@REM #  
@REM #   [2018] - [2021] Bacon Unlimited 
@REM #   All Rights Reserved.
@REM #  
@REM #  NOTICE:  All information contained herein is, andins
@REM #  the property of Bacon Unlimited and its suppliers,
@REM #  if any.  The intellectual and technical concepts contained
@REM #  herein are proprietary to Bacon Unlimited
@REM #  and its suppliers and may be covered by U.S. and Foreign Patents,
@REM #  patents in process, and are protected by trade secret or copyright law.
@REM #  Dissemination of this information or reproduction of this material
@REM #  is strictly forbidden unless prior written permission is obtained
@REM #  from Bacon Unlimited.
@REM ################################################################################

@REM # This shows usage of a salt-call command to run a single Bacon state.
@REM # Bacon states are referenced using the following scheme:
@REM #
@REM # bacon.states.{state_platform}.{slugify(state_name)}_{state_id}
@REM #
@REM # where state_platform is the Platform (OS) the state was created for,
@REM # state_name is a slugified version of the state name 
@REM # (slugified as per these rules https://docs.djangoproject.com/en/3.2/ref/utils/#django.utils.text.slugify),
@REM # and state_id is the numeric ID for the state (can be found at the end of the URL when viewing the state).
@REM # The first example below shows how you would reference a Windows state called "Install Chrome" with an id of 20.

@REM # If you want a script that only ever applies a single state, you can use
@REM # this example:
salt-call state.apply bacon.states.Windows.install-chrome_20

@REM # If you want to specify which state to apply when executing the script,
@REM # you could use one of these two alternatives instead:

@REM # Alternative method to accept a command line argument for the state name
@REM # salt-call state.apply $1

@REM # Alternative method to accept a template variable for the state name
@REM # salt-call state.apply {{state}}
