<#
.SYNOPSIS  
    Removes the local machine from Active Directory

.DESCRIPTION  
    Takes user-supplied username and password
    (templated variables) and unbinds the machine. 

.NOTES  
    File Name  : ad_unbind.ps1  
    Author     : Matt Porter <mporter@twe-solutions.com> 
#>

$password = "{{ad_password:password,noescape}}" | ConvertTo-SecureString -asPlainText -Force
$username = "$domain\{{ad_username}}" 

$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Remove-Computer -UnjoinDomainCredential $credential -Force
