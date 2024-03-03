#cd C:\Users\champuser\SYS-320-Automation-and-scripting\week2
clear

function runChamplain() {
    if ( Get-Process -Name "chrome" ){ #-ErrorAction SilentlyContinue
        Stop-Process -Name "chrome"
    }

    else {
        Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" `
        -ArgumentList "champlain.edu"
    }
}

