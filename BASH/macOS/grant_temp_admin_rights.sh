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

# This script grants a Mac user temporary admin rights.
# You can specify a username by passing an argument for -u or --username with the
# desired username.  If you do not pass a username, the current logged in user 
# will be given admin rights.
# The default time limit is 10 minutes, but you can specify a different time limit
# by passing an argument for -t or --timer and providing the desired number of
# minutes (e.g., 15).

# The script creates a launch daemon to remove the admin rights after the time
# limit is reached.  The daemon will still run even if the system is restarted
# or the user logs out.  If the system restarts, the daemon will run immediately
# once it is loaded again.

# Preliminary script setup steps
set -Eeuo pipefail

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

# This function will parse the command-line parameters
parse_params() {
  # Set the default values
  username=''
  timer=10

  while :; do
    case "${1-}" in
    -u | --username)
      username="${2-}"
      shift
      ;;
    -t | --timer)
      timer=${2-}
      shift
      ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done
}

parse_params "$@"

# Set username to current logged in user if no username was provided
if [[ -z "${username-}" ]]; then
    username=$(who | awk '/console/{print $1}')
fi

timer_in_secs=$((timer*60))

# Create script to remove admin rights
if [ ! -d /private/var/removeAdmin ]; then
    mkdir -p /private/var/removeAdmin
fi

cat << 'EOF' > /private/var/removeAdmin/removeAdminRights.sh
if [[ -f /private/var/removeAdmin/user ]]; then
    removeAdmin=$(cat /private/var/removeAdmin/user)
    /usr/sbin/dseditgroup -o edit -d $removeAdmin -t user admin
    rm -f /private/var/removeAdmin/user
    rm /Library/LaunchDaemons/removeAdmin.plist
    launchctl remove removeAdmin
fi
EOF

# Create and load daemon to remove admin rights after the time is up
sudo defaults write /Library/LaunchDaemons/removeAdmin.plist Label -string "removeAdmin"
sudo defaults write /Library/LaunchDaemons/removeAdmin.plist ProgramArguments -array -string "/bin/sh" -string "/private/var/removeAdmin/removeAdminRights.sh"
sudo defaults write /Library/LaunchDaemons/removeAdmin.plist StartInterval -integer $timer_in_secs
sudo defaults write /Library/LaunchDaemons/removeAdmin.plist RunAtLoad -boolean yes
sudo chown root:wheel /Library/LaunchDaemons/removeAdmin.plist
sudo chmod 644 /Library/LaunchDaemons/removeAdmin.plist
launchctl load /Library/LaunchDaemons/removeAdmin.plist
sleep 10 # to wait for daemon to initially load and run

# Store username to remove admin rights from
echo $username > /private/var/removeAdmin/user

# Give the user admin rights
/usr/sbin/dseditgroup -o edit -a $username -t user admin

# Notify user that admin rights have been granted
osascript -e 'display alert "Temporary Admin Rights" message "Administrative rights have been granted to '"$username"' for '"$timer"' minutes." as critical buttons {"OK"} default button 1' >/dev/null 2>&1 &
