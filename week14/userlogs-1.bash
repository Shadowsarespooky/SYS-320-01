#! /bin/bash

authfile="/var/log/auth.log"

function getLogins(){
 logline=$(cat "$authfile" | grep "systemd-logind" | grep "New session")
 dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,11 | tr -d '\.')
 echo "$dateAndUser"
}

function getFailedLogins(){
# Todo - 1
# a) Make a little research and experimentation to complete the function
# b) Generate failed logins and test
 failedlog=$(cat "$authfile" | egrep "[fF]ailure")
 dateAndUser=$(echo "$failedlog" | grep "champuser" | cut -d' ' -f1,2,3,16 | sed s/user=//g )
 echo "$dateAndUser"
}

# Sending logins as email - Do not forget to change email address
# to your own email address
echo "To: jaden.cypes@mymail.champlain.edu" > emailform.txt
echo "Subject: Logins" >> emailform.txt
getLogins >> emailform.txt
cat emailform.txt | ssmtp jaden.cypes@mymail.champlain.edu

# Todo - 2
# Send failed logins as email to yourself.
# Similar to sending logins as email
echo "To: jaden.cypes@mymail.champlain.edu" > emailform.txt
echo "Subject: Failed Logins" >> emailform.txt
echo "Here's the failed logins" >> emailform.txt #will not send failed logins without this line
getFailedLogins >> emailform.txt
cat emailform.txt | ssmtp jaden.cypes@mymail.champlain.edu

