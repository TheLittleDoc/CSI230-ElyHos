.("C:\Users\champuser\Documents\CSI230-ElyHos\Local User Management Menu\Event-Logs.ps1")
.("C:\Users\champuser\Documents\CSI230-ElyHos\Scheduled Email Reports\Configuration.ps1")
.("C:\Users\champuser\Documents\CSI230-ElyHos\Scheduled Email Reports\Email.ps1")
.("C:\Users\champuser\Documents\CSI230-ElyHos\Scheduled Email Reports\Scheduler.ps1")
cd "C:\Users\champuser\Documents\CSI230-ElyHos\Scheduled Email Reports\"
$configuration = Get-Configuration
$failed = getAtRiskUsers -numDays $configuration.Days
Send-Email ($failed | Format-Table | Out-String)

Select-Time -time $configuration.Time