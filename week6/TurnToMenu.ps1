. (Join-Path $PSScriptRoot ParseApacheLogs.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot ProcessManaScp4.ps1)

#clear screen
clear

$Prompt = "Please choose your operation:`n"
$Prompt += "1: Display last 10 apache logs `n"
$Prompt += "2: Display last 10 failed logins for all users`n"
$Prompt += "3: Display at risk users`n"
$Prompt += "4: Start Chrome and go to Champlain.edu`n"
$Prompt += "5: Exit`n"

$operation = $true

while($operation){

    Write-Host $Prompt | Out-String
    $choice = Read-Host 

    if ($choice -eq 5) {
        Write-Host "All done!" | Out-String
        exit
        $operation = $false
    }

    elseif ($choice -eq 1) {
        $lastTenLogs = ApacheLogs1 | select -Last 10
        $lastTenLogs
    }

    elseif ($choice -eq 2) {
            $days = Read-Host -Prompt "Please enter the number of days for the user's failed login logs"
            $userLogins = getFailedLogins $days

            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Select -Last 10 | Format-Table | Out-String)
    }

    elseif ($choice -eq 3) {
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

    elseif ($choice -eq 4) {
        runChamplain
    }

    else {
        Write-Host "That is not an operation. Please choose again.`n" | Out-String
    }
}