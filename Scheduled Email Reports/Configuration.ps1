function Get-Configuration() {
    $configLines = Get-Content "configuration.txt"
    $configuration = [pscustomobject]@{
        "Days" = $configLines[0];
        "Time" = $configLines[1];
    }
    return $configuration
}
$timeRegex = "^(1[0-2]|0?[1-9]):[0-5][0-9] [A,P]M$"

function Write-Configuration() {
    
    do{
        $numDays = Read-Host -Prompt "Please enter the number of days to search"
        $numDaysInt = [int]$numDays
        if($numDaysInt -isnot [int]) {
            Write-Host "Please provide a positive integer.`n"
        }
    } while($numDaysInt -isnot [int])
    do{
        $time = Read-Host -Prompt "Please enter the time at which to execute"
        if($time -notmatch $timeRegex) {
            Write-Host "Please provide a time in format 'HH:MM AM'.`n"
        }
    } while($time -notmatch $timeRegex)

    if($time -match "^0") {
        $time = $time.Substring(1)
    }
    $configuration = [pscustomobject]@{
        "Days" = $numDays;
        "Time" = $time;
    }

    $configuration | Format-Table -AutoSize

    $fileOutput = $numDays + "`n" + $time | Out-File -FilePath "configuration.txt"
    
}


$Prompt  = "Please choose your operation:`n"
$Prompt += "1 - Show Configuration`n"
$Prompt += "2 - Change Configuration`n"
$Prompt += "3 - Exit`n"

function Enable-Menu(){
    $operation = $true

    while($operation){

        Write-Host $Prompt | Out-String
        $choice = Read-Host 


        if($choice -eq 3){
            Write-Host "Goodbye" | Out-String
            exit
            $operation = $false 
        } elseif($choice -eq 1) {
            Get-Configuration

        } elseif($choice -eq 2) {
            Write-Configuration
        } else {
            Write-Host "Invalid selection. Please choose an option between 1 and 3.`n" | Out-String
        }
    }
}

#Enable-Menu