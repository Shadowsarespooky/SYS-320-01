#clear the screen
clear

function scrapedIOC () {
    $scraped_page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.5/IOC.html

    $trs = $scraped_page.ParsedHTML.body.getElementsByTagName("tr")

    $patterns = @()

    for ($i=1; $i -lt $trs.length; $i++) {
        $tds = $trs[$i].getElementsByTagName("td");
        $patterns += [pscustomobject]@{"Pattern" = $tds[0].innerText; "Explantion" = $tds[1].innerText}
    } # end of for loop

    return $patterns

}
scrapedIOC | Format-Table


function obtainApacheLogs () {
    $logs = Get-Content -Path C:\Users\champuser\SYS-320-Automation-and-scripting\week8\access.log
    $records = @()

    for ($i = 0; $i -lt $logs.Count; $i++) {
        $parts = $logs[$i].Split(" ");

        $records += [pscustomobject]@{ "IP" = $parts[0]; `
                                       "Time" = $parts[3].Trim('['); `
                                       "Method" = $parts[5].Trim('"'); `
                                       "Page" = $parts[6]; `
                                       "Protocal" = $parts[7]; `
                                       "Response" = $parts[8]; `
                                       "Referrer" = $parts[10]; }
    } # end of for loop

    return $records
}
obtainApacheLogs | Format-Table

function findIndicators ($tds, $records) {

    $newRecords = @()
  
    foreach ($log in $records){

        foreach ($pattern in $tds) {
          
           $test = $pattern.Pattern

           if ($log.Page -match $test) {
                   $newRecords += $log
           }
        } # end of inner foreach loop
    } # end of outer foreach loop

    return $newRecords | Group-Object -Property 'Page' | ForEach-Object { $_.Group[0]} | Format-Table
    
}

$tds = scrapedIOC
$records = obtainApacheLogs

findIndicators $tds $records



