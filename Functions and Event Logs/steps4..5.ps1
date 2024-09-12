function Get-LoginEvents($days) {
    $loginEvents = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$days)
    $loginTable = @()
    for($i = 0; $i -lt $loginEvents.Count; $i++) {

        $time = $loginEvents[$i].TimeGenerated
        $id = $loginEvents[$i].EventID

        $event = ""
        if($loginEvents[$i].EventID -eq 7001) {$event = "Logon"}
        if($loginEvents[$i].EventID -eq 7002) {$event = "Logoff"}

        $sid = New-Object System.Security.Principal.SecurityIdentifier($loginEvents[$i].ReplacementStrings[1])
        $user = $sid.Translate([System.Security.Principal.NTAccount]).Value
        $loginTable += [ PSCustomObject ]@{
            "Time" = $time
            "Id" = $id
            "Event" = $event
            "User" = $user
        }
    }

    $loginTable
}

function Get-PowerEvents($days) {
    $powerEvents = Get-EventLog System -After (Get-Date).AddDays(-$days) | Where-Object { $_.EventID -eq 6005 -or $_.EventID -eq 6006 }
    $powerTable = @()

    for($i = 0; $i -lt $powerEvents.Count; $i++) {
        $time = $powerEvents[$i].TimeGenerated
        $id = $powerEvents[$i].EventID

        $event = ""
        if($powerEvents[$i].EventID -eq 6005) {$event = "Startup"}
        if($powerEvents[$i].EventID -eq 6006) {$event = "Shutdown"}
        $user = "System"

        $powerTable += [ PSCustomObject ]@{
            "Time" = $time
            "Id" = $id
            "Event" = $event
            "User" = $user
        }
    }
    $powerTable
        
}


