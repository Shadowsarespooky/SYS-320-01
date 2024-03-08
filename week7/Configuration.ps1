# clear the screen
clear

# Function Declarations and Definitions

function readConfiguration () {
    $file = Get-Content -Path C:\Users\champuser\SYS-320-Automation-and-scripting\week7\configuration.txt

    $data = $file.Split("`n")

    $a = @()
    $a += [pscustomobject]@{ "Days" = $data[0]; `
                             "ExecutionTime" = $data[1]; }
    #Write-Host ($a | Format-Table | Out-String)
}

function changeConfiguration () {
    $operation = $true
    while ($operation) {
        $newDays = Read-Host -Prompt "Enter the new amount of days. Please enter only numbers"
        $newTime = Read-Host -Prompt "Enter the new time. Please enter as #:## AM/PM"

        if ($newDays -match '[\d+]' ){
            if ($newTime -match '\d+:\d\d [AP]M') {
                Set-Content -Path C:\Users\champuser\SYS-320-Automation-and-scripting\week7\configuration.txt -value $newDays, $newTime
                Write-Host "Configuration Changed `n"
                return
            }
            else {
                Write-Host "Please enter the correct format." | Out-String
            }
        }

        else {
            Write-Host "Please enter a number." | Out-String
        }
    }

}

function configurationMenu () {
    # Menu Selection

    $Prompt = "Please choose your operation:`n"
    $Prompt += "1: Show configuration`n"
    $Prompt += "2: Change configuration`n"
    $Prompt += "3: Exit`n"

    $operation = $true

    while($operation) {
        Write-Host $Prompt | Out-String
        $choice = Read-Host
    
        if($choice -eq 3){ 
            Write-Host "All done!" | Out-String
            exit
            $operation = $false
        }

        elseif($choice -eq 1){
            readConfiguration
        }

        elseif($choice -eq 2){
            changeConfiguration
        }

        else {
            Write-Host "That is not a choice!" | Out-String
        }
    }
}





