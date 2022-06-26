# Script used to check port connectivity from a Windows endpoint to a server, preferably the Bacon server
# To run: call "bacon_port_check.py bacon.yourdomain.com 1
# This script will perform as many connections as possible inside of the defined minute limit, for each port.
# A setting of one minute will take three because it will check all three Bacon ports: 4505, 4506, 4507
# At the end of each port check, a message will show how many attempts succeeded and how many failed.


param ($fqdn, $minutes)

$ports = 4505,4506,4507
foreach ($i in $ports)
{
    $count = 0;
    $nocount = 0;
    $attempt = 0;
    $endtime = new-timespan -Minutes $minutes
    $starttime = [diagnostics.stopwatch]::StartNew()
    while($starttime.elapsed -lt $endtime)
    {
        if ((New-Object System.Net.Sockets.TcpClient -ArgumentList $fqdn, $i).Connected)
        {
            $count += 1;
        }
        else {
            $nocount += 1;
        }
        $attempt += 1;
    }
    Write-Output "$fqdn -port $i passed $count/$attempt times and failed $nocount/$attempt times in the past $minutes minutes."
}
