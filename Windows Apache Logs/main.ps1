cd "C:\Users\champuser\Documents\CSI230-ElyHos\Windows Apache Logs\"
. (Join-Path $PSScriptRoot "Get-Visitors.ps1")

$ips = Get-Visitors -page "/index.html" -code "200" -browser "Firefox"

$ipsoften = $ips | Where-Object { $_.IP -ilike "1*" }
$counts = $ipsoften | Group-Object IP
$counts | Select Count,Name