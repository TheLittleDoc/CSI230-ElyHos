. (Join-Path $PSScriptRoot "steps4..5.ps1")

$loginTable = Get-LoginEvents(15)
$loginTable

$powerEvents = Get-PowerEvents(25)
$powerEvents
