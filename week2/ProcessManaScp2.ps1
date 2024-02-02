# cd C:\Users\champuser\SYS-320-Automation-and-scripting\week2
clear

Get-Process | Where-Object { $_.Path -notlike '*system32*' } | `
Format-Table -Property ProcessName, Id, Path
