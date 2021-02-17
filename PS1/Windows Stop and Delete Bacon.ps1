$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)

Stop-Service -Name "salt-minion"
Remove-Item �path c:\salt\conf -Recurse -Force -Confirm:$false