#!/bin/bash
file=~/Test/sample.txt
search=things
replacement=yourself
# Replaces only the first match for the search pattern in the file
sed -i -e "0,/$search/s//$replacement/" "$file"
