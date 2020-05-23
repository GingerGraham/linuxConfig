dir=~/dotFiles
echo "Directory is $dir"
for file in $(find $dir -type f -name ".*" -exec basename {} \; );
do
	if [ $file != ".gitignore" ]
	then
		ln -s $dir/$file ~/Test/$file
	fi
done
