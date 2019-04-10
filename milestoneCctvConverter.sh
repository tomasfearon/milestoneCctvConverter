#!/bin/bash

#	Script: milestoneCctvConverter.sh
#	Author:	Tomas FEARON
#	Date Created: 2019-04-04
#	Date Updated: 2019-04-08
#	Purpose - Concatenates .pic and .chk files from Milestone CCTV unit and converts them so they can be viewed

#	Usage - ./milestoneCctvConverter.sh [Path to Mediadatabase folder] 

#	Notes	-	The .pic .chk files contain H264/AVC video streams with a frame rate of 25
# 				No spaces in file paths!
#				To exit before completion, close terminal window

#	Exit Codes
#	0	-	Successful Execution
#	1	-	Command-line args not supplied

############ CODE START ##########################################################################

# Check for compusory args
if [ -z $1 ]
then
	echo
	echo "Error - Insufficient Command-line Arguments."
	echo "Use format - ./milestoneCctvConverter.sh [Path to Mediadatabase folder]"
	echo 
	echo "Exiting..."
	echo
	exit 1
fi

# Read args to variables
mediaDB=${1}

# Intro message
clear
echo "*****		Welcome to ${0}		*****"
echo
echo "This script will attempt to convert Mediadatabase exports containing .pic/.chk files from Milestone CCTV units into viewable video"
echo
echo "Videos will be in .avi container format. They will be named by date and exported into the same folder that holds the .pic/.chk files for that camera."
echo
echo "To exit the script before completion, close the terminal window"
echo
echo "Press any key to start"
read anyKey


# For each dir in Mediadatabase folder
for camDir in "${mediaDB}"*
do
	# For each date dir camera dir
	for dateDir in "${camDir}"/*
	do
		# Name output file after date. Get from dir name and cam dir
		outputFileName="${dateDir}/$(echo ${dateDir} | awk -F'/' '{print $2 "_" $3}').avi"
				
		# For get list of .pic and .chk files sorted by number
		picFiles=$(ls -d -1 "${dateDir}/"**.pic "${dateDir}/"**.chk | sort -t_ -k3,3n)
		picFiles=$(echo ${picFiles})
		
		echo
		echo "Input Directory:	${dateDir}"
		echo "Number of .pic files:	$(echo ${picFiles} | wc -w)"
		echo "Output:	${outputFileName}"

		# Concatenate and convert
		echo
		echo "Attempting to merge video at $(date --rfc-3339)."
		echo "Please wait, this will take some time..."
		
		# Demuxer type: H264_ES, fps taken from mediainfo, concatenate all files and package as AVI. Redirect stderr to prevent errors if .chk not present
		mencoder -really-quiet -demuxer 30 -fps 25 -oac copy -ovc lavc -of avi ${picFiles} -o ${outputFileName} 2> /dev/null
		
		echo
		echo "${outputFileName} done! Time Completed: $(date --rfc-3339)"
	done
done
	
# Exit if successful 
echo
echo
echo "Script complete at $(date --rfc-3339). Exiting."
exit 0
