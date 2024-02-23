function IPFilter ( $pageVisited, $HTTPCode, $webBrowser ) {
# Get the logs
$logs = Get-Content -Path "C:\xampp\apache\logs\access.log"

# Make a regex of things to match, and escape the special characters that may be present in the line
$regVisited = [regex]::Escape($pageVisited)
$regCode = [regex]::Escape($HTTPCode)
$regBrowser = [regex]::Escape($webBrowser)

# Filter the logs
$filtered = $logs | Where-Object { $_ -match $regVisited -and $_ -match $regCode -and $_ -match $regBrowser }

# create empty array and add the ip addresses in the loop
$ipAdds = @()
foreach ($log in $filtered) {
    $ipAdds += ($log -split '\s+')[0]
}

# group the ipAddresses and then how to display them
$ipCount = $ipAdds | Group-Object
$ipCount | Select-Object Count, Name
}