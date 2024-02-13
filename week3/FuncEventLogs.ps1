#clear the screen
clear

#Get-EventLog system | where-object { $_.source -ilike "Microsoft-Windows-*"} | select source
# 1 Get login and logoff records from Windows Events
#Get-EventLog system -source Microsoft-Windows-winlogon

<# 2 Get login and logff records from windows events and save to variable
# Get the last 14 days
$loginouts = Get-EventLog system -Source Microsoft-Windows-winlogon -After (Get-Date).AddDays(-14)
#Write-Host $loginouts
$loginoutsTable = @() # Empty array to fill customly
for($i=0; $i -lt $loginouts.count; $i++){
#Create event property value
$event = ""
if($loginouts[$i].InstanceID -eq 7001) {$event="Logon"}
if($loginouts[$i].InstanceID -eq 7002) {$event="Logoff"}
# create user property value
$user = $loginouts[$i].ReplacementStrings[1]
# add each new line (in form of custom object) to our empty array
$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                       "Id" = $loginouts[$i].InstanceId; `
                                       "Event" = $event; `
                                       "User" = $user;
                        }
} # End of for loop
$loginoutsTable #>

<# 3 Use System Security Principle SecuirtyIdentifier to translate user id to username
$loginouts = Get-EventLog system -Source Microsoft-Windows-winlogon -After (Get-Date).AddDays(-14)
#Write-Host $loginouts
$loginoutsTable = @() # Empty array to fill customly
for($i=0; $i -lt $loginouts.count; $i++){
#Create event property value
$event = ""
if($loginouts[$i].InstanceID -eq 7001) {$event="Logon"}
if($loginouts[$i].InstanceID -eq 7002) {$event="Logoff"}
# create user property value
$user = $loginouts[$i].ReplacementStrings[1]
$username = [System.Security.Principal.SecurityIdentifier]::new($user).Translate([System.Security.Principal.NTAccount])
# add each new line (in form of custom object) to our empty array
$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                       "Id" = $loginouts[$i].InstanceId; `
                                       "Event" = $event; `
                                       "User" = $username;
                        }
} # End of for loop
$loginoutsTable #>

# 4 Turn the script into a function such that it will take one input and return a table of results
# The input is the number of days for which you obtain the logs
# Call your function with the parmeter and print the results on the screen
function getLogEvents($days) {
$loginouts = Get-EventLog system -Source Microsoft-Windows-winlogon -After (Get-Date).AddDays(-$days)
#Write-Host $loginouts
$loginoutsTable = @() # Empty array to fill customly
for($i=0; $i -lt $loginouts.count; $i++){
#Create event property value
$event = ""
if($loginouts[$i].InstanceID -eq 7001) {$event="Logon"}
if($loginouts[$i].InstanceID -eq 7002) {$event="Logoff"}
# create user property value
$user = $loginouts[$i].ReplacementStrings[1]
$username = [System.Security.Principal.SecurityIdentifier]::new($user).Translate([System.Security.Principal.NTAccount])
# add each new line (in form of custom object) to our empty array
$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                       "Id" = $loginouts[$i].InstanceId; `
                                       "Event" = $event; `
                                       "User" = $username;
                        }
} # End of for loop
#Write-Host "Going back $days days"
$loginoutsTable
} # End of function
#getLogEvents 15

# 5 Create another function to obtain computer start and shut-down times
function getStartShutEvents ($days) {
$startonoff = Get-EventLog -LogName System -After (Get-Date).AddDays(-$days) | `
where-object { $_.EventID -eq 6005 -or $_.EventID -eq 6006}

$startonoffTable = @() #empty array to fill with custom objects

for ($i=0; $i -lt $startonoff.count; $i++) {

#create event property value
$event = ""
if($startonoff[$i].EventID -eq 6006) {$event="ShutDown"}
if($startonoff[$i].EventID -eq 6005) {$event="StartUp"}


$startonoffTable += [pscustomobject]@{"Time" = $startonoff[$i].TimeGenerated; `
                                      "Id" = $startonoff[$i].EventID; `
                                      "Event" = $event; `
                                      "User" = "System";
                                      }
} # End of for loop
#Write-Host "Going Back $days days"
$startonoffTable
}
# getStartShutEvents 14

