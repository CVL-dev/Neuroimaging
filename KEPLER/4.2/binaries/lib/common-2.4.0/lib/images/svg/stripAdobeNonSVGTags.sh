#!/bin/sh

#
# Simple shell script that uses sed to strip all the unused crapola 
# from SVG files that is originally put there by Adobe Illustrator
#
# @Author Matthew Brooke
#
# $Id: stripAdobeNonSVGTags.sh 24234 2010-05-06 05:21:26Z welker $

# list all SVG files in dir and save them in a text file
fileList="fileList.txt"
ls *.svg > $fileList

#startTag="<i:pgf "
#endTag="<\/i:pgf>"


cat $fileList | while read nextFile 
do
    echo "Deleting all unused Illustrator nonsense in file $nextFile"

    mv $nextFile  ORIG_$nextFile

	echo "renamed original file to ORIG_$nextFile"
	
	outputFile=$nextFile
      
	echo "deleting unwanted section...."

	## command is like: sed -e '/\<i\:pgf /,/\<\/i\:pgf\>/d'
	#
    sed -e '/\<i\:pgf /,/\<\/i\:pgf\>/d' ORIG_$nextFile | sed -e '/\<metadata\>/,/\<\/metadata\>/d' > $outputFile

	echo "...finished $outputFile"

done

rm $fileList

