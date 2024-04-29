#! /bin/bash
# Challenge-2
# Write a script that lists apache logs,
# that contain indicators of compromise

# take in two files as input
if [ $# -ne 2 ]; then
	echo "Please enter the files to be used"
	exit 1
fi
access="$1"
ioc="$2"

# filter out the logs
declare -a reportContent

while read -r logline; do
	while read -r phrase; do
		# output the IP, date/time,and page accessed
		content=$(echo "$logline" | grep "$phrase" | cut -d ' ' -f1,4,7 | tr -d '[')
		reportContent+=("$content")
	done < "$ioc"
done < "$access"

# save to file named report.txt
echo "Suspicious Activity:" > report.txt
printf "%s\n" "${repotContent[@]}" | sort -u >> report.txt
