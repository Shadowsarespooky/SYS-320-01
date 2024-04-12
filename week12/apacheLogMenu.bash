#! /bin/bash

#run getLogs.bash first to get access.txt
logFile="access.txt"

function displayAllLogs(){
	cat "$logFile"
}

function displayOnlyIPs(){
        cat "$logFile" | cut -d ' ' -f 1 | sort -n | uniq -c
}

# function: displayOnlyPages:
# like displayOnlyIPs - but only pages
function displayOnlyPages(){
	cat "$logFile" | cut -d ' ' -f 7 | sort -n | uniq -c
}

function histogram(){

	local visitsPerDay=$(cat "$logFile" | cut -d " " -f 4,1 | tr -d '['  | sort \
                              | uniq)
	# This is for debugging, print here to see what it does to continue:
	# echo "$visitsPerDay"

        :> newtemp.txt  # what :> does is in slides
	echo "$visitsPerDay" | while read -r line;
	do
		local withoutHours=$(echo "$line" | cut -d " " -f 2 \
                                     | cut -d ":" -f 1)
		local IP=$(echo "$line" | cut -d  " " -f 1)

		local newLine="$IP $withoutHours"
		echo "$IP $withoutHours" >> newtemp.txt
	done
	cat "newtemp.txt" | sort -n | uniq -c
}

# function: frequentVisitors:
# Only display the IPs that have more than 10 visits
# You can either call histogram and process the results,
# Or make a whole new function. Do not forget to separate the
# number and check with a condition whether it is greater than 10
# the output should be almost identical to histogram
# only with daily number of visits that are greater than 10

function frequentVisitors(){
	local visitors=$(cat "$logFile" | cut -d ' ' -f 1 | sort -n | uniq -c )
	local dates=$(cat "$logFile" | cut -d ' ' -f 4 | tr -d '[' | cut -d':' -f 1 | sort | uniq)
	declare -a frequentVis

#	echo "$visitors"
#	echo "$dates"
	while read -r line; do
		count=$(echo "$line" | awk '{print $1}')
		if [[ "$count" -ge 10 ]]; then
# I was getting two counts for two different days for the same IP address when using the histogram
# I wanted to count the total of one IP address, and then display the dates for it. 
			frequentVis+=("$line" "Dates:" "$dates" )
		fi
	done <<< "$visitors"
	echo "Frequent Visitors: "
	printf '%s\n' "${frequentVis[@]}"
}

# function: suspiciousVisitors
# Manually make a list of indicators of attack (ioc.txt)
# filter the records with this indicators of attack
# only display the unique count of IP addresses.
# Hint: there are examples in slides
function suspiciousVisitors(){
	touch ioc.txt
	echo "etc/passwd" >> ioc.txt
	echo "/bin/sh" >> ioc.txt
	echo "/bin/bash" >> ioc.txt
	echo "\.\./" >> ioc.txt
	echo "cmd\.exe" >> ioc.txt

	echo "Suspicious Visitors: "
	cat access.txt | egrep -i -f ioc.txt | cut -d' ' -f 1 | sort -n | uniq -c
}

# Keep in mind that I have selected long way of doing things to
# demonstrate loops, functions, etc. If you can do things simpler,
# it is welcomed.

while :
do
	echo "PLease select an option:"
	echo "[1] Display all Logs"
	echo "[2] Display only IPS"
	# Display only pages visited
	echo "[3] Display only Pages"
	echo "[4] Histogram"
	# Frequent visitors
	echo "[5] Display Frequent Vistors"
	# Suspicious visitors
	echo "[6] Display Suspicious Vistors"
	echo "[7] Quit"

	read userInput
	echo ""

	if [[ "$userInput" == "7" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		echo "Displaying all logs:"
		displayAllLogs

	elif [[ "$userInput" == "2" ]]; then
		echo "Displaying only IPS:"
		displayOnlyIPs

	# Display only pages visited
	elif [[ "$userInput" == "3" ]]; then
		echo "Displaying only Pages:"
		displayOnlyPages

	elif [[ "$userInput" == "4" ]]; then
		echo "Histogram:"
		histogram

        # Display frequent visitors
	elif [[ "$userInput" == "5" ]]; then
		frequentVisitors

	# Display suspicious visitors
	elif [[ "$userInput" == "6" ]]; then
		suspiciousVisitors

	# Display a message, if an invalid input is given
	else
		echo "Invalid input, try again."
	fi
done

