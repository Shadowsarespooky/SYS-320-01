function ChooseTimeToRun($Time) {
    $scheduledTasks = Get-ScheduledTask | Where-Object { $_.TaskName -ilike "myTask" }

    if ($scheduledTasks -ne $null) {
        Write-Host "The task already exists." | Out-String
        DisableAutoRun
    }

    Write-Host "Creating new task" | Out-String
    $action = New-ScheduledTaskAction -Execute "powershell.exe" `
        -Argument "-File `"C:\Users\champuser\SYS-320-Automation-and-scripting\week7\main.ps1`""

    $trigger = New-ScheduledTaskTrigger -Daily -At $Time
    $principal = New-ScheduledTaskPrincipal -UserId 'champuser' -RunLevel Highest
    $settings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -WakeToRun
    $task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings

    Register-ScheduledTask 'myTask' -InputObject $task

    Get-ScheduledTask | Where-Object { $_.TaskName -ilike "myTask" }
}

function DisableAutoRun() {

    $scheduledTasks = Get-ScheduledTask | Where-Object { $_.TaskName -ilike "myTask" }

    if ($scheduledTasks -ne $null) {
        Write-Host "Unregistering the task." | Out-String
        Unregister-ScheduledTask -TaskName 'myTask' -Confirm:$false
    }

    else {
        Write-Host "The task is not registered." | Out-String
    }
}