$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)

Install-Module pswindowsupdate -acceptall
get-windowsupdate
Start-Sleep -s 15
Install-WindowsUpdate