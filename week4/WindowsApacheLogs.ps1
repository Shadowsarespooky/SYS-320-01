#clear the screen
clear
# 1 List all of the apache logs of xampp
#Get-Content -Path C:\xampp\apache\logs\access.log

# 2 List only the last
#Get-Content -Path C:\xampp\apache\logs\access.log -Tail 5

# 3 Display only the logs that contain 404 (Not-Found) or 400 (Bad Request) 
#Get-Content -Path C:\xampp\apache\logs\access.log | Select-String ' 404 ',' 400 '

# 4 Display only the logs that does NOT contain 200 (OK)
#Get-Content -Path C:\xampp\apache\logs\access.log | Select-String '200' -NotMatch

# 5 From every file with .log extentsion in the directory, only get logs that contain the word 'error'
#$A = Get-ChildItem -Path C:\xampp\apache\logs\*.log | Select-String -Pattern 'error'
# Display the last 5 elements of the result array
#$A[-5..-1]

# 6 Display only IP addresses for 404 (Not found) records
# Get only logs that contain 404, save into $notfounds
$notfounds = Get-Content -Path C:\xampp\apache\logs\access.log | Select-String ' 404 ' 
# Define the regex pattern for IP addresses
$regex = [regex] "\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b"
# Get $notfounds records that match to the regex
$ipsUnorganized = $regex.Matches($notfounds)
# Get ips as pscustomobject
$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++) {
    $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value;}
}
#$ips | Where-Object { $_.IP -ilike "10.*"}

# 7 Count $ips from above
$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*"}
$counts = $ipsoftens | Group IP
$counts | Select-Object Count, Name
