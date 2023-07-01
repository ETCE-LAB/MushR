#!/bin/bash
if [ $# -eq 0 ]
then
   echo "No filename supplied, using generating new filename"
   FILENAME="$(date +"%Y%m%d_%H%M%S").jpg"
else
   FILENAME=$1
fi


libcamera-still --denoise cdn_hq --awbgain 4.5,3.4 --contrast 1.5 --exposure long -t 3 -n -o /home/mushr2/mushrimg/$FILENAME

echo "Rotating +90°"

convert -rotate "+90" /home/mushr2/mushrimg/$FILENAME /home/mushr2/mushrimg/$FILENAME
