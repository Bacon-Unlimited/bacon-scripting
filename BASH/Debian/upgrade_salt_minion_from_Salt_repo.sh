#!/usr/bin/env bash

################################################################################
#  
#  Bacon Unlimited
#  __________________
#  
#   [2018] - [2021] Bacon Unlimited 
#   All Rights Reserved.
#  
#  NOTICE:  All information contained herein is, and remains
#  the property of Bacon Unlimited and its suppliers,
#  if any.  The intellectual and technical concepts contained
#  herein are proprietary to Bacon Unlimited
#  and its suppliers and may be covered by U.S. and Foreign Patents,
#  patents in process, and are protected by trade secret or copyright law.
#  Dissemination of this information or reproduction of this material
#  is strictly forbidden unless prior written permission is obtained
#  from Bacon Unlimited.
################################################################################

# Downloads the Salt pkg installer directly from Salt's repo - requires Internet access on minion
target_salt_version="3002.6"
codename=$(lsb_release -cs)

if [ "$(lsb_release -is)" = "Ubuntu" ]; then
    os="ubuntu"
    os_ver="$(lsb_release -rs)"
else
    os="debian"
    os_ver="$(lsb_release -rs | awk '{print int($0)}')"
fi

salt_repo_url="https://repo.saltproject.io/py3/${os}/${os_ver}/amd64/archive/${target_salt_version}"

# Delete old Salt repos
find /etc/apt/sources.list.d/ -type f -name "salt*" -delete

# Add Salt repo
salt-call pkg.mod_repo "deb ${salt_repo_url} ${codename} main" file="/etc/apt/sources.list.d/salt.list" clean_file=True humanname="SaltStack Debian Repo" key_url="${salt_repo_url}/SALTSTACK-GPG-KEY.pub"

# Upgrade Salt minion
{ apt -y update && apt -y install salt-minion && systemctl restart salt-minion; } >/dev/null 2>&1 &
