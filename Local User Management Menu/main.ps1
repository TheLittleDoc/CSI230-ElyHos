. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt  = "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - Get At-Risk Users`n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"

        if((checkUser -name $name) -eq $false) {
            
            $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"
            $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
            $plaintext = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
            if((checkPassword -password $plaintext)) {

                createAUser $name $password

                Write-Host "User: $name is created." | Out-String
            } 
        } else {
            Write-Host "User already exists." | Out-String
        }
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        # TODO: Check the given username with the checkUser function.

        removeAUser $name

        Write-Host "User: $name Removed." | Out-String
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        if((checkUser -name $name) -ne $true) {
            Write-Host "User does not exist" | Out-String
            
        } else {
            enableAUser $name

            Write-Host "User: $name Enabled." | Out-String
    
        }

    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

       
        if((checkUser -name $name) -ne $true) {
            Write-Host "User does not exist" | Out-String
            
        } else {
            disableAUser $name

            Write-Host "User: $name Disabled." | Out-String
        }
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        
        if((checkUser -name $name) -ne $true) {
            Write-Host "User does not exist" | Out-String
            
        } else {
            $numDays = Read-Host -Prompt "Please enter the number of days to search"
            $userLogins = getLogInAndOffs $numDays

            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        if((checkUser -name $name) -ne $true) {
            Write-Host "User does not exist" | Out-String
            
        } else {
            $numDays = Read-Host -Prompt "Please enter the number of days to search"
            $userLogins = getFailedLogins $numDays

            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
    }


    elseif($choice -eq 9) {
        $numDays = Read-Host -Prompt "Please enter the number of days to search"
        $userLogins = getFailedLogins $numDays

        $userLogins | Group-Object User | Where-Object {$_.Count -gt 9} | Select Count, Name | Format-Table -AutoSize


    } else {
        Write-Host "Invalid selection. Please make a selection between 1 and 10." | Out-String
    }
    

}




