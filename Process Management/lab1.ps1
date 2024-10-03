clear
#Get-Process | Where-Object { $_.ProcessName -ilike "c*" }
#Get-Process | Where-Object { $_.Path -inotlike "*system32*" }

#$folderpath="$PSScriptRoot\outfolder"
#if(Test-Path $folderpath) {
#    Write-Host "Folder Already Exists"
#}
#else {
#    New-Item -ItemType Directory -Path $folderpath
#}

#cd $folderpath

#$filePath = Join-Path $folderpath "out.csv"

#$services = (Get-Service | Where-Object { $_.Status -ilike "Stopped" })
#$services
#$services | Sort-Object | Export-Csv -Path $filePath


if ((Get-Process chrome -ea SilentlyContinue)) {
    Get-Process chrome | Stop-Process
} else {
    Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList '"https://champlain.edu"'
}
