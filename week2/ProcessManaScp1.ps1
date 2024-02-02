# cd C:\Users\champuser\SYS-320-Automation-and-scripting\week2
clear

Get-Process | Where-Object { $_.ProcessName -ilike 'C*' }