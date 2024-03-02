. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot String-Helper.ps1)

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
$Prompt += "9 - List at Risk Users `n"
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
        $password = Read-Host -Prompt "Please enter the password for the new user"
        # TODO: Create a function called checkUser in Users that: 
        #              - Checks if user a exists. - If user exists, returns true, else returns false
        $checkUserStatus = checkUser $name
        # TODO: Check the given username with your new function.
        #              - If false is returned, continue with the rest of the function - If true is returned, do not continue and inform the user
        if ($checkUserStatus -eq $false) {
            # TODO: Create a function called checkPassword in String-Helper that:
            #              - Checks if the given string is at least 6 characters
            #              - Checks if the given string contains at least 1 special character, 1 number, and 1 letter
            #              - If the given string does not satisfy conditions, returns false
            #              - If the given string satisfy the conditions, returns true
            $checkPassStatus = checkPassword $password
            if ($checkPassStatus -eq $true) {  
                # TODO: Check the given password with your new function. 
                #              - If false is returned, do not continue and inform the user
                #              - If true is returned, continue with the rest of the function
                $passwordEn = $password | ConvertTo-SecureString -AsPlainText -Force
                createAUser $name $passwordEn
                Write-Host "User: $name is created." | Out-String
            }
            else {
                Write-Host "Password doesn't meet criteria: Must contain 6 or more characters, must have 1 letter, 1 number, and 1 special character."
            }
        }
        else {
            Write-Host "User already exists."
        }

    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        # TODO: Check the given username with the checkUser function.
        $checkUserStatus = checkUser $name
        if ($checkUserStatus -eq $false) { 
            Write-Host "User: $name does not exist" | Out-String
        }
        else {
            removeAUser $name
            Write-Host "User: $name Removed." | Out-String
        }
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        # TODO: Check the given username with the checkUser function.
        $checkUserStatus = checkUser $name
        if ($checkUserStatus -eq $false) { 
            Write-Host "User: $name does not exist" | Out-String
        }
        else {
            enableAUser $name
            Write-Host "User: $name Enabled." | Out-String
        }
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        # TODO: Check the given username with the checkUser function.
        $checkUserStatus = checkUser $name
        if ($checkUserStatus -eq $false) { 
            Write-Host "User: $name does not exist" | Out-String
        }
        else {
            disableAUser $name
            Write-Host "User: $name Disabled." | Out-String
        }        
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        # TODO: Check the given username with the checkUser function.
        $checkUserStatus = checkUser $name
        if ($checkUserStatus -eq $false) { 
            Write-Host "User: $name does not exist" | Out-String
        }
        else {
            $days = Read-Host -Prompt "Please enter the number of days for the user logs"
            $userLogins = getLogInAndOffs $days
            # TODO: Change the above line in a way that, the days 90 should be taken from the user

            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }  

    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        # TODO: Check the given username with the checkUser function.
        $checkUserStatus = checkUser $name
        if ($checkUserStatus -eq $false) { 
            Write-Host "User: $name does not exist" | Out-String
        }
        else {
            $days = Read-Host -Prompt "Please enter the number of days for the user's failed login logs"
            $userLogins = getFailedLogins $days
            # TODO: Change the above line in a way that, the days 90 should be taken from the user

            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
    }

    elseif($choice -eq 9){
    # TODO: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers
        #Prompt for days
        $days = Read-Host -Prompt "Please enter the number of days for the failed login logs"
        
        # get the list of users with failed logins
        $failedLogins = getFailedLogins $days

        # filter the users with more than 10 failed logins
        $atRiskUsers = $failedLogins | Group-Object -Property User | Where-Object { $_.Count -gt 10 }

        #Display at-risk users
        Write-Host "Users with more than 10 failed logins in the last $days days:" | Out-String
        foreach ($i in $atRiskUsers) {
            Write-Host "Users: $($i.Name)", "Count: $($i.Count)" | Out-String
        }
    
    }

    else {
    # TODO: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
        Write-Host ("That's not an option, please choose again." | Out-String)
    
    }

}




