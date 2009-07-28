#!/bin/bash
# replacestring.sh:
# Replace a particular string in binaries in a specified directory.
# usage: ./replacestring.sh dir 'src str' 'rpl str'

for file in $( find $1 -type f | sort )
do
mv $file $file.orig
sed "s/$2/$3/g" $file.orig > $file
rm -f $file.orig
done  

