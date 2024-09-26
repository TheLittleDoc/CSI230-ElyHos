. (Join-Path $PSScriptRoot "Windows Apache Logs\Get-Visitors.ps1")
. (Join-Path $PSScriptRoot "Parsing Apache Logs\Get-ApacheLogs.ps1")

#$ips = Get-Visitors -page "/index.html" -code "200" -browser "Firefox"
#
#$ipsoften = $ips | Where-Object { $_.IP -ilike "1*" }
#$counts = $ipsoften | Group-Object IP
#$counts | Select Count,Name

$tableOutput = Get-ApacheLogs
$tableOutput | Format-Table -AutoSize