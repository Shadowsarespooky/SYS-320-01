clear

function gatherClasses(){
$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.21/Courses.html
#Downloading the data, may take some time

#Get all the tr elements of HTML document
$trs=$page.ParsedHTML.body.getElementsByTagName("tr")

# Empty Array to hold elements
$FullTable = @()
for($i = 1; $i -lt $trs.length; $i++) {
    # Get every td element of current tr element
    $tds = $trs[$i].getElementsByTagName("td")
   # Write-Host $tds
    # Want to seperate start time and end time from one time field
    $Times = $tds[5].innerText.split("-")
   # Write-Host $Times
    $FullTable += [pscustomobject]@{"Class Code" = $tds[0].innerText; `
                                    "Title"      = $tds[1].innerText; `
                                    "Days"       = $tds[4].innerText; `
                                    "Time Start" = $Times[0]; `
                                    "Time End"   = $Times[1]; `
                                    "Instructor" = $tds[6].innerText; `
                                    "Location"   = $tds[9].innerText; `
                                    }
}# end of for loop

return $FullTable
}

function daysTranslator($FullTable) {
#Go over every record in the Table
for($i=0; $i -lt $FullTable.length; $i++) {
    #Empty array to hold days for every record
    $Days = @()

    # If you see "M" -> Monday
    if($FullTable[$i].Days -ilike "M*"){ $Days += "Monday"}

    # If you see "T" followed by T,W, or F -> Tuesday
    if($FullTable[$i].Days -ilike "*T[TWF]*"){ $Days += "Tuesday"}
    
    # If you see "W" -> Wednesday
    if($FullTable[$i].Days -ilike "*W*"){ $Days += "Wednesday"}
    
    # If you see "TH" -> Thursday
    if($FullTable[$i].Days -ilike "*TH*"){ $Days += "Thursday"}
    
    # If you see "F" -> Friday
    if($FullTable[$i].Days -ilike "*F"){ $Days += "Friday"}

    # If you see "TBA" -> TBA
    if($FullTable[$i].Days -ilike "TBA"){ $Days += "TBA"}
    
    # Make the switch
    $FullTable[$i].Days = $Days
}
return $FullTable
}
