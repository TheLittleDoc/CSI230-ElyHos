#!/bin/bash

file="/var/log/apache2/access.log"

result=$(cat "$file" | cut -d' ' -f1,12 | grep "curl" | sort | uniq -c )

echo "$result"
