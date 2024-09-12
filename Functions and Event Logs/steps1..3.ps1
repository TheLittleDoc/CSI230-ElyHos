$loginEvents = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)
$loginTable = @()
for($i = 0; $i -lt $loginEvents.Count; $i++) {

    $time = $loginEvents[$i].TimeWritten
    $id = $loginEvents[$i].EventID

    $event = ""
    if($loginEvents[$i].InstanceID -eq 7001) {$event = "Logon"}
    if($loginEvents[$i].InstanceID -eq 7002) {$event = "Logoff"}

    $sid = New-Object System.Security.Principal.SecurityIdentifier($loginEvents[$i].ReplacementStrings[1])
    $user = $sid.Translate([System.Security.Principal.NTAccount]).Value
    $loginTable += [ PSCustomObject ]@{
        "Time" = $time
        "Id" = $loginEvents[$i].EventID
        "Event" = $event
        "User" = $user
    }
}



$loginTable