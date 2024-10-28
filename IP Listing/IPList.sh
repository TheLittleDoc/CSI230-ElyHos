#!/bin/bash

trap ctrl_c INT

function ctrl_c() {
    echo "Exiting without grace...."
    # Perform cleanup or other actions here
    exit 2
}

[ "$#" -ne 1 ] && echo "Usage: $0 <prefix>" && exit 1

prefix="$1"
expr="(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
[[ ${#1} -lt 5 || ${#1} -gt 12 ]] && echo "<prefix> should be between 5 and 11 characters" && exit 1

#echo "$(ip addr)"
for i in {1..255}
do
	ping -w 1 -c 1 "$prefix.$i" | grep "64 bytes" | \
	 grep -o -E "$expr"
done
