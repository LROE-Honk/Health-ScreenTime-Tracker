#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OUTPUT_DIR="$SCRIPT_DIR/images"
DEVICE="/dev/video0"  # Set to the correct device if needed

CAPTURE_INTERVAL="0.05" # in seconds
FFMPEG=ffmpeg
command -v $FFMPEG >/dev/null 2>&1 || { FFMPEG=avconv ; }
DIFF_RESULT_FILE=$OUTPUT_DIR/diff_results.txt

fn_cleanup() {
	rm -f diff.png $DIFF_RESULT_FILE
}

fn_terminate_script() {
	fn_cleanup
	echo "SIGINT caught."
	exit 0
}
trap 'fn_terminate_script' SIGINT

mkdir -p $OUTPUT_DIR
PREVIOUS_FILENAME=""
while true ; do
	FILENAME="$OUTPUT_DIR/$(date +"%Y%m%dT%H%M%S").jpg"
	echo "-----------------------------------------"
	echo "Capturing $FILENAME from $DEVICE"
	if [[ "$OSTYPE" == "linux-gnu" ]]; then
		if ! $FFMPEG -f video4linux2 -i $DEVICE -vframes 1 $FILENAME; then
			echo "Error capturing image with $FFMPEG from $DEVICE. Please check your device and settings."
			sleep $CAPTURE_INTERVAL
			continue
		fi
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		# Mac OSX
		if ! $FFMPEG -f avfoundation -i "default" -vframes 1 $FILENAME; then
			echo "Error capturing image with $FFMPEG from $DEVICE. Please check your device and settings."
			sleep $CAPTURE_INTERVAL
			continue
		fi
	fi
	
	if [[ -f "$FILENAME" && "$PREVIOUS_FILENAME" != "" ]]; then
		compare -fuzz 20% -metric ae $PREVIOUS_FILENAME $FILENAME diff.png 2> $DIFF_RESULT_FILE
		if [[ $? -ne 0 ]]; then
			echo "Error comparing images. Check the image files and compare command."
			fn_cleanup
			sleep $CAPTURE_INTERVAL
			continue
		fi
		DIFF="$(cat $DIFF_RESULT_FILE)"
		fn_cleanup
		if [ "$DIFF" -lt 20 ]; then
			echo "Same as previous image: delete (Diff = $DIFF)"
			rm -f $FILENAME
		else
			echo "Different image: keep (Diff = $DIFF)"
			PREVIOUS_FILENAME="$FILENAME"
		fi
	else
		PREVIOUS_FILENAME="$FILENAME"
	fi
	
	sleep $CAPTURE_INTERVAL
done
