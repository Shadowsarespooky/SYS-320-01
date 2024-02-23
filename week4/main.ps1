. (Join-Path $PSScriptRoot Apache-Logs.ps1)

clear

$filteredIps = IPfilter index.html 200 Chrome
$filteredIps