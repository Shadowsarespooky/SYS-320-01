#!bin/bash

allLogs=""
file="/var/log/apache2/access.log"

function getAllLogs(){
allLogs=$(cat "$file" | cut -d' ' -f1,4,7 | tr -d "[")
}

function pageCount(){
count=$(echo "$allLogs" | sort -k 3 | cut -d' ' -f3 | uniq -c )
}

#function ips(){
#ipsAccessed=$(echo "$allLogs" | cut -d' ' -f1 )
#}

getAllLogs
pageCount
echo "$count"
