# clear the screen 
clear

function SendAlertEmail($Body) {
    $From = "jaden.cypes@mymail.champlain.edu"
    $To = "jaden.cypes@mymail.champlain.edu"
    $Subject = "Sus Activity"

    $Password = "uywb iqrw mblr jbie" | ConvertTo-SecureString -AsPlainText -Force
    $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

    Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" `
    -port 587 -UseSsl -Credential $Credential
}

SendAlertEmail "Body of email"