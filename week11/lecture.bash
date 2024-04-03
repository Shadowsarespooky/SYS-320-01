#!bin/bash

allLogs=""
file="/var/log/apache2/access.log"

function getAllLogs(){
allLogs=$(cat "$file" | cut -d' ' -f1,4,7 | tr -d "[")
}

function pageCount(){
count=$(echo "$allLogs" | sort -k 3 | cut -d' ' -f3 | uniq -c )
}

function ips(){
ipsAccessed=$(echo "$allLogs" | cut -d' ' -f1 )
}

function countingCurlAccess(){
curlCount=$(cat "$file" | cut -d' ' -f1,12 | grep 'curl' | uniq -c )
}

countingCurlAccess
echo "$curlCount"
