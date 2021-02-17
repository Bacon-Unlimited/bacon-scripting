<#
.SYNOPSIS  
    renames a computer

.DESCRIPTION  
    Takes user-supplied username, password, and domain
    (templated variables) and binds the machine. 

#>

$domain = "{{domain}}"
$password = "{{ad_password:password,noescape}}" | ConvertTo-SecureString -asPlainText -Force
$username = "$domain\{{ad_username}}" 

$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Rename-Computer -NewName "{{comutername}}" -DomainCredential $credential -force -restart