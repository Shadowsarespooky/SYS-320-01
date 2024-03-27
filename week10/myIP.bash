#!/bib/bash

# Script to run the ip addr command
# But return only the network ip such as mine: 10.0.17.33

ipPattern="([0-9]{1,3}\.){3}[0-9]{1,3}"

result=$( ip addr | grep -E "$ipPattern" | awk '{print $2}' | grep -E -v '127|255' | awk -F '/' '{print $1}' )

# print the ip address
echo "$result"
