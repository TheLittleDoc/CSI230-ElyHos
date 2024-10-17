function Select-Time($time) {
    $scheduledTasks = Get-ScheduledTask | Where-Object { $_.TaskName -ilike "week7" }
    if($scheduledTasks -ne $null) {
        Write-Host "This task already exists" | Out-String
        Disable-AutoRun
    }

    Write-Host "Creating new task" | Out-String

    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-File `"C:\Users\champuser\Documents\CSI230-ElyHos\Scheduled Email Reports\main.ps1`""
    $trigger = New-ScheduledTaskTrigger -Daily -At $time
    $principal = New-ScheduledTaskPrincipal -UserId "champuser" -RunLevel Highest
    $settings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -WakeToRun
    $task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings

    Register-ScheduledTask "week7" -InputObject $task
    Get-ScheduledTask | Where-Object { $_.TaskName -ilike "week7" }

}

function Disable-AutoRun() {

    $scheduledTasks = Get-ScheduledTask | Where-Object { $_.TaskName -ilike "week7" }
    if($scheduledTasks -ne $null) {
        Write-Host "Unregistering this task" | Out-String
        Unregister-ScheduledTask -TaskName "week7" -Confirm:$false
    } else {
        Write-Host "This task does not exist" | Out-String
    }
}