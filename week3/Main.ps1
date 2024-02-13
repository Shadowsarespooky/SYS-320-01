. (Join-Path $PSScriptRoot FuncEventLogs.ps1)

clear

# Get Login and Logoffs from the last 15 days
$loginoutsTable = getLogEvents 15
$loginoutsTable

# Get Shutdowns and Startups from the last 25 days
$startonoffTable = getStartShutEvents 25
$startonoffTable