#!/bin/bash
if [ $# -eq 0 ]
then
   echo "No filename supplied, using generating new filename"
   FILENAME="$(date +"%Y%m%d_%H%M%S").jpg"
else
   FILENAME=$1
fi

./arducam_multicamera.py --camera A --camera-preset FULL -o /home/pi/mushrimg/Camera2.A/$FILENAME
./arducam_multicamera.py --camera B --camera-preset FULL -o /home/pi/mushrimg/Camera2.B/$FILENAME
./arducam_multicamera.py --camera C --camera-preset FULL -o /home/pi/mushrimg/Camera2.C/$FILENAME

echo "Rotating +90°"

convert -rotate "+90" /home/pi/mushrimg/Camera2.A/$FILENAME /home/pi/mushrimg/Camera2.A/$FILENAME
convert -rotate "+90" /home/pi/mushrimg/Camera2.B/$FILENAME /home/pi/mushrimg/Camera2.B/$FILENAME
convert -rotate "+90" /home/pi/mushrimg/Camera2.C/$FILENAME /home/pi/mushrimg/Camera2.C/$FILENAME
