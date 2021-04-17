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

# Delete old Salt repos
find /etc/yum.repos.d/ -type f -name "salt*" -delete

# Add Salt repo
salt-call pkg.mod_repo salt enabled=1 gpgcheck=1 name="SaltStack repo for RHEL/CentOS \$releasever" baseurl="https://repo.saltproject.io/py3/redhat/\$releasever/\$basearch/archive/${target_salt_version}" gpgkey="https://repo.saltproject.io/py3/redhat/\$releasever/\$basearch/archive/${target_salt_version}/SALTSTACK-GPG-KEY.pub"

# Upgrade Salt minion
{ yum -y update salt-minion && systemctl restart salt-minion; } >/dev/null 2>&1 &
