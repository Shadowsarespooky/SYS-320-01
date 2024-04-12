#! /bin/bash

# If access.txt is not ready, get it first
logFile="access.txt"

if [[ ! -f "${logFile}" ]]
then
	bash getLogs.bash
fi

# getting the IPs
cut -d' ' -f 1 access.txt | sort | uniq
