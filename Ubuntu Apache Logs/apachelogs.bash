#!/bin/bash

file="/var/log/apache2/access.log"

result=$(cat "$file" | cut -d' ' -f1,7 | grep "page2")

echo "$result"
