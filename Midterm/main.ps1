.("C:\Users\champuser\Documents\CSI230\Repos\CSI230-ElyHos\Midterm\ParseApacheLogs.ps1")
.("C:\Users\champuser\Documents\CSI230\Repos\CSI230-ElyHos\Midterm\ScrapeIOC.ps1")

$iocPatterns = Get-IOCList
$suspectLogs = Get-SuspectLogs -ioc $iocPatterns
$suspectLogs | Format-Table