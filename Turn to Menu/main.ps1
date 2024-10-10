.("C:\Users\champuser\Documents\CSI230-ElyHos\Local User Management Menu\Event-Logs.ps1")

function Get-ApacheLogs($count) {
    $logs = Get-Content C:\xampp\apache\logs\access.log
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
            "Client" = $words[11..($words.Length - 1)] -join " "
        }
    }
    return $tableLog | Where-Object { $_.IP -ilike "1*" } | Select -Last $count | Format-Table -AutoSize
}

clear

$Prompt  = "Please choose your operation:`n"
$Prompt += "1 - Display last 10 Apache logs`n"
$Prompt += "2 - Display last 10 failed logins`n"
$Prompt += "3 - Display at-risk users`n"
$Prompt += "4 - Start Chrome`n"
$Prompt += "5 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        Get-ApacheLogs -count 10
    }

    elseif($choice -eq 2) {
        $numDays = Read-Host -Prompt "Please enter the number of days to search"
        $logins = getFailedLogins -timeBack $numDays
        Write-Host ($logins | Select -Last 10 | Out-String)
    }

    elseif($choice -eq 3) {
        $numDays = Read-Host -Prompt "Please enter the number of days to search"
        $userLogins = getFailedLogins $numDays

        $userLogins | Group-Object User | Where-Object {$_.Count -gt 9} | Select Count, Name | Format-Table -AutoSize
    }

    elseif($choice -eq 4) {
        if ((Get-Process chrome -ea SilentlyContinue)) {
            Get-Process chrome | Stop-Process
        } else {
            Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList '"https://champlain.edu"'
        }
    }

    else {
        Write-Host "Invalid choice. Please make a selection between 1 and 5." | Out-String
    }

}