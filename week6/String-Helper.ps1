<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}

function checkPassword ($pass) {
    Write-Host $password
    if ($password.length -lt 6) {
        Write-Host "1"
        return $false
    }
    elseif($password -inotlike '*[0-9]*'){
        Write-Host "2"
        return $false
    }
    elseif($password -inotlike '*[a-zA-Z]*'){
        Write-Host "3"
        return $false
    }
    elseif($password -inotlike '*[!@#$%&?]*') {
        Write-Host "4"
        return $false
    }
    else {
        return $true
    }
}
