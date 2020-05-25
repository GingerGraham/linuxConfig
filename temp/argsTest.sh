#!/bin/sh

while getopts a:b:c: option
do
	case "${option}"
		in
		a) varA=${OPTARG};;
		b) varB=${OPTARG};;
		c) varC=${OPTARG};;
	esac
done

echo "You provided $# arguments\n"
echo "All your arguments were: " $@

if [ -z "$varA" ]; then
	varA="No argument supplied for a"
elif [ -z "$varB" ]; then
	varB="No argument supplied for b"
elif [ -z "$varC" ]; then
	varC="No argument supplied for c"
fi
echo "Your arguments were:\na:$varA\nb:$varB\nc:$varC\n"
