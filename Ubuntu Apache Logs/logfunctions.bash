#!/bin/bash

logsOutput=""
ips=""
count=""
file="/var/log/apache2/access.log"

function getAllLogs()
{
	logsOutput=$(cat "$file" | cut -d' ' -f1,4,7 | tr -d "[" )
}

function getAllIPAddresses
{
	ips=$(cat "$file" | cut -d' ' -f1)
}

function accessCounts()
{
	count=$(cat "$file" | cut -d' ' -f7 | sort | uniq -c)
}

#getAllLogs
#getAllIPAddresses
accessCounts
#echo "$logsOutput"
#echo "$ips"
echo "$count"
