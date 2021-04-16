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

# You need to have the appropriate Salt EXE installer uploaded to Bacon to use this script.
$target_salt_version = "3002.6"

salt-call cp.get_url "salt://packages/Windows/Salt-Minion-$target_salt_version-Py3-AMD64-Setup.exe" "C:\temp\SaltInstall_$target_salt_version.exe" makedirs=True

Start-Process -FilePath "C:\temp\SaltInstall_$target_salt_version.exe" -ArgumentList "/S"
