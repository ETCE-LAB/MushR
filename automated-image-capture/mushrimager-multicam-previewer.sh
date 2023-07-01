#!/bin/bash

if [ $# -ne 3 ]
then
    echo "Insufficient arguments: mushrimager-multicam-previewer.sh <tent no> <camera no> <image previewer command>"
    exit 1
fi

ssh mushr2@digit-25-196.digit.tu-clausthal.de "/home/mushr2/scripts/turn-on-lights.sh"

if [[ "$1" -eq "1" ]]
then
    ssh pi@digit-25-197.digit.tu-clausthal.de "/home/pi/scripts/arducam_multicamera.py -p FULL -c $2 -o /tmp/maintenance-preview.jpg" && \
    scp pi@digit-25-197.digit.tu-clausthal.de:/tmp/maintenance-preview.jpg /tmp/maintenance-preview.jpg 
elif [[ "$1" -eq "2" ]]
then
    ssh pi@digit-25-195.digit.tu-clausthal.de "/home/pi/scripts/arducam_multicamera.py -p FULL -c $2 -o /tmp/maintenance-preview.jpg" && \
    scp pi@digit-25-195.digit.tu-clausthal.de:/tmp/maintenance-preview.jpg /tmp/maintenance-preview.jpg 
fi

ssh mushr2@digit-25-196.digit.tu-clausthal.de "/home/mushr2/scripts/turn-off-lights.sh"
$3 /tmp/maintenance-preview.jpg
