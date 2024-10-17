function Get-ApacheLogs() {
    $logs = Get-Content C:\Users\champuser\Downloads\access.log
    $tableLog = @()

    for($i = 0; $i -lt $logs.Count; $i++) {
        $words = $logs[$i].Split(" ")
        $tableLog += [pscustomobject]@{
            "IP" = $words[0];
            "Time" = $words[3].TrimStart("[") + " " + $words[4].TrimEnd("]");
            "Method" = $words[5].TrimStart('"');
            "Page" = $words[6];
            "Protocol" = $words[7].TrimEnd('"');
            "Response" = $words[8];
            "Referrer" = $words[10];
            #"Client" = $words[11..($words.Length - 1)] -join " "
        }
    }
    return $tableLog | Where-Object { $_.IP -ilike "1*" }
}

function Get-SuspectLogs($ioc) {
    $logs = Get-ApacheLogs
    $suspectLogs = @()
    $iocMatch = $ioc.Pattern -join "|"
    for($i = 0; $i -lt $logs.Count; $i++) {
        if($logs[$i].Page -match $iocMatch) {
                $suspectLogs += $logs[$i]
        }
    }
    return $suspectLogs
}
