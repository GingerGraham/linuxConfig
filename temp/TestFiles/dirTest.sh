#!/bin/bash
# testDir=~/.Test
# file=~/testFile.txt
# mkdir -p $testDir
# mv $file $testDir

dir1=/home/gwatts

[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

dir2=$HOME

echo "Directory 1 is $dir1 and directory 2 is $dir2"

if [[ -d $dir1/.ssh ]]; then
	echo "$dir1/.ssh exists"
else
	echo "$dir1/.ssh does not exist"
fi
