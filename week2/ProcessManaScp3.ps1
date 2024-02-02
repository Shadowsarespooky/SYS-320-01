# cd C:\Users\champuser\SYS-320-Automation-and-scripting\week2
clear

$sortedFiles = Get-Service | Where-Object { $_.Status -eq "stopped" } | `
Sort-Object -Property DisplayName

$filePath = "C:\Users\champuser\SYS-320-Automation-and-scripting\week2\stopservices.csv"
$sortedFiles | Export-Csv -Path $filePath

ls C:\Users\champuser\SYS-320-Automation-and-scripting\week2