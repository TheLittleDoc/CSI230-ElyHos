# cd '.\Documents\PowerShell Basic Lab - 1'
#
# $files=(Get-ChildItem)
# for ($j=0; $j -le $files.Length; $j++) {
#     if($files[$j].Name -ilike "*ps1") {
#         Write-Host $files[$j].Name
#     }
# }

#$folderpath="$PSScriptRoot\outfolder"
#if(Test-Path $folderpath) {
#    Write-Host "Folder Already Exists"
#}
#else {
#    New-Item -ItemType Directory -Path $folderpath
#}

#cd $PSScriptRoot
#$files=(Get-ChildItem)
#
#$folderpath = "$PSScriptRoot\outfolder"
#$filePath = Join-Path $folderpath "out.csv"
#
#$files | Where-Object { $_.Extension -eq ".ps1" } |
#Export-Csv -Path $filePath

$files = Get-ChildItem -Recurse -File
$files | Rename-Item -NewName { $_.Name -replace '.csv', '.log' } | Write-Host
Get-ChildItem -Recurse -File