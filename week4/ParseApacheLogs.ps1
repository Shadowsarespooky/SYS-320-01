clear # clear the screen

function ApacheLogs1() {

$logsNotformatted = Get-Content -Path C:\xampp\apache\logs\access.log
$tableRecords = @()

for ($i=0; $i -lt $logsNotformatted.Count; $i++){
# split a string into words
$words = $logsNotformatted[$i].Split(" ");

$tableRecords += [pscustomobject]@{ "IP" = $words[0]; `
                                    "Time" = $words[3..4].Trim('['); `
                                    "Method" = $words[5].Trim('"'); `
                                    "Page" = $words[6]; `
                                    "Protocol" = $words[7]; `
                                    "Response" = $words[8]; `
                                    "Referrer" = $words[10]; `
                                    "Client" = $words[11..($words.Count-1)]; }
    } # end of loop
return $tableRecords | Where-Object { $_.IP -ilike "10.*" }
}