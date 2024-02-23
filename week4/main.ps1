. (Join-Path $PSScriptRoot Apache-Logs.ps1)
. (Join-Path $PSScriptRoot ParseApacheLogs.ps1)

clear

$filteredIps = IPfilter index.html 200 Chrome
$filteredIps

$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap
