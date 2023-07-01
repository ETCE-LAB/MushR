#!/bin/bash

##  Copyright (C) 2022, 2023 Anant Sujatanagarjuna

#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Affero General Public License as
#  published by the Free Software Foundation, either version 3 of the
#  License, or (at your option) any later version.

#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU Affero General Public License for more details.

#  You should have received a copy of the GNU Affero General Public License
#  along with this program.  If not, see <https://www.gnu.org/licenses/>.


DATE=$(date +"%Y%m%d_%H%M%S")

irsend SEND_START RGB5050remote KEY_POWER
sleep 1
irsend SEND_STOP  RGB5050remote KEY_POWER

./arducam_multicamera.py --camera A --camera-preset FULL -o /home/pi/mushrimg/Camera1.A/$DATE.jpg
./arducam_multicamera.py --camera B --camera-preset FULL -o /home/pi/mushrimg/Camera1.B/$DATE.jpg
./arducam_multicamera.py --camera C --camera-preset FULL -o /home/pi/mushrimg/Camera1.C/$DATE.jpg

echo "Rotating +90°"

convert -rotate "+90" /home/pi/mushrimg/Camera1.A/$DATE.jpg /home/pi/mushrimg/Camera1.A/$DATE.jpg
convert -rotate "+90" /home/pi/mushrimg/Camera1.B/$DATE.jpg /home/pi/mushrimg/Camera1.B/$DATE.jpg
convert -rotate "+90" /home/pi/mushrimg/Camera1.C/$DATE.jpg /home/pi/mushrimg/Camera1.C/$DATE.jpg

irsend SEND_START RGB5050remote KEY_POWER2
sleep 5

irsend SEND_STOP  RGB5050remote KEY_POWER2

echo "Uploading to OwnCloud"

curl -T /home/pi/mushrimg/Camera1.A/$DATE.jpg https://tucloud.tu-clausthal.de/remote.php/webdav/Mushrimg/Camera1.A/$DATE.jpg --netrc-file /home/pi/scripts/tucloud.txt
curl -T /home/pi/mushrimg/Camera1.B/$DATE.jpg https://tucloud.tu-clausthal.de/remote.php/webdav/Mushrimg/Camera1.B/$DATE.jpg --netrc-file /home/pi/scripts/tucloud.txt
curl -T /home/pi/mushrimg/Camera1.C/$DATE.jpg https://tucloud.tu-clausthal.de/remote.php/webdav/Mushrimg/Camera1.C/$DATE.jpg --netrc-file /home/pi/scripts/tucloud.txt

curl -T /home/pi/mushrimg/Camera1.B/$DATE.jpg https://tucloud.tu-clausthal.de/remote.php/webdav/MushrSnapshot/Tent1-Latest.jpg --netrc-file /home/pi/scripts/tucloud.txt

echo "Pushing to git"

cd /home/pi/gits/mushr-snapshot/
cp /home/pi/mushrimg/Camera1.B/$DATE.jpg /home/pi/gits/mushr-snapshot/Tent1-Latest.jpg
git add Tent1-Latest.jpg
git commit -m "Update Latest Image"
git push origin
