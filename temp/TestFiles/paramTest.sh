#!/bin/bash
input=$1
test=$input
if [ -d $test ]
then
	echo "Directory $input exists!"
else
	echo "Directory $input does not exist!"
fi

dir=$PWD
echo $dir
