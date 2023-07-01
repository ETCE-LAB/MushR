#!/bin/bash

DATE=$(date +"%Y%m%d_%H%M%S")

ssh mushr2@digit-25-196.digit.tu-clausthal.de "/home/mushr2/scripts/turn-on-lights.sh"

/home/pi/scripts/arducam_multicamera.py --camera A --camera-preset FULL -o /home/pi/mushrimg/Camera2.A/$DATE.jpg
/home/pi/scripts/arducam_multicamera.py --camera B --camera-preset FULL -o /home/pi/mushrimg/Camera2.B/$DATE.jpg
/home/pi/scripts/arducam_multicamera.py --camera C --camera-preset FULL -o /home/pi/mushrimg/Camera2.C/$DATE.jpg

echo "Rotating +90°"

convert -rotate "+90" /home/pi/mushrimg/Camera2.A/$DATE.jpg /home/pi/mushrimg/Camera2.A/$DATE.jpg
convert -rotate "+90" /home/pi/mushrimg/Camera2.B/$DATE.jpg /home/pi/mushrimg/Camera2.B/$DATE.jpg
convert -rotate "+90" /home/pi/mushrimg/Camera2.C/$DATE.jpg /home/pi/mushrimg/Camera2.C/$DATE.jpg

echo "Connecting to Tent 1"

ssh pi@digit-25-197.digit.tu-clausthal.de "/home/pi/scripts/mushrimager-multicam-noremote.sh $DATE.jpg"

echo "Copying images from Tent 1"

scp pi@digit-25-197.digit.tu-clausthal.de:/home/pi/mushrimg/Camera1.A/$DATE.jpg /tmp/Tent1-A.jpg
scp pi@digit-25-197.digit.tu-clausthal.de:/home/pi/mushrimg/Camera1.B/$DATE.jpg /tmp/Tent1-B.jpg
scp pi@digit-25-197.digit.tu-clausthal.de:/home/pi/mushrimg/Camera1.C/$DATE.jpg /tmp/Tent1-C.jpg

ssh mushr2@digit-25-196.digit.tu-clausthal.de "/home/mushr2/scripts/turn-off-lights.sh" &

echo "Uploading latest images to OwnCloud"

curl -T /home/pi/mushrimg/Camera2.A/$DATE.jpg https://tucloud.tu-clausthal.de/remote.php/webdav/Mushrimg/Camera2.A/$DATE.jpg --netrc-file /home/pi/scripts/tucloud.txt
curl -T /home/pi/mushrimg/Camera2.B/$DATE.jpg https://tucloud.tu-clausthal.de/remote.php/webdav/Mushrimg/Camera2.B/$DATE.jpg --netrc-file /home/pi/scripts/tucloud.txt
curl -T /home/pi/mushrimg/Camera2.C/$DATE.jpg https://tucloud.tu-clausthal.de/remote.php/webdav/Mushrimg/Camera2.C/$DATE.jpg --netrc-file /home/pi/scripts/tucloud.txt


curl -T /tmp/Tent1-A.jpg https://tucloud.tu-clausthal.de/remote.php/webdav/Mushrimg/Camera1.A/$DATE.jpg --netrc-file /home/pi/scripts/tucloud.txt
curl -T /tmp/Tent1-B.jpg https://tucloud.tu-clausthal.de/remote.php/webdav/Mushrimg/Camera1.B/$DATE.jpg --netrc-file /home/pi/scripts/tucloud.txt
curl -T /tmp/Tent1-C.jpg https://tucloud.tu-clausthal.de/remote.php/webdav/Mushrimg/Camera1.C/$DATE.jpg --netrc-file /home/pi/scripts/tucloud.txt

