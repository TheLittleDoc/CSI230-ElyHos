<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}

function checkPassword($password) {
    if($password.Length -lt 6) {
        Write-Host "Password must be 6 or more characters" | Out-String
        return $false
    } elseif($password -cnotlike "*[0-9]*") {
        Write-Host "Password must contain at least one number" | Out-String
        return $false
    } elseif($password -cnotlike "*[~,!,@,#,$,%,^,&,*,(,),_,+,-,=]*") {
        Write-Host "Password must contain at least one special character" | Out-String
        return $false
    } elseif($password -cnotlike "*[A-z]*") {
        Write-Host "Password must contain at least one letter" | Out-String
        return $false
    } else {
        Write-Host "Passed."
        return $true
    }
    return $false
}