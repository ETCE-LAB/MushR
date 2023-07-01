#  Copyright (C) 2022, 2023 Anant Sujatanagarjuna

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

#!/bin/bash

DATE=$(date +"%Y%m%d_%H%M%S")

irsend SEND_START RGB5050remote KEY_POWER
sleep 1
irsend SEND_STOP  RGB5050remote KEY_POWER

libcamera-still --denoise cdn_hq --awbgain 4.5,3.4 --contrast 1.5 --exposure long -t 3 -n -o /home/mushr/mushrimg/$DATE.jpg

echo "Rotating -90°"

convert -rotate "-90" /home/mushr/mushrimg/$DATE.jpg /home/mushr/mushrimg/$DATE.jpg

echo "Connecting to Tent 2"

ssh mushr2@139.174.28.175 "/home/mushr2/scripts/mushrimager-noremote.sh $DATE.jpg"

echo "Copying image from Tent2"

scp mushr2@139.174.28.175:/home/mushr2/mushrimg/$DATE.jpg /tmp/Tent2-Latest.jpg

irsend SEND_START RGB5050remote KEY_POWER2
sleep 5

irsend SEND_STOP  RGB5050remote KEY_POWER2

echo "Uploading to OwnCloud"

curl -T /home/mushr/mushrimg/$DATE.jpg https://tucloud.tu-clausthal.de/remote.php/webdav/MushrSnapshot/Tent1-Latest.jpg --netrc-file /home/mushr/scripts/tucloud.txt

curl -T /tmp/Tent2-Latest.jpg https://tucloud.tu-clausthal.de/remote.php/webdav/MushrSnapshot/Tent2-Latest.jpg --netrc-file /home/mushr/scripts/tucloud.txt

echo "Pushing to git"

cd /home/mushr/gits/mushr-snapshot/
cp /home/mushr/mushrimg/$DATE.jpg /home/mushr/gits/mushr-snapshot/Tent1-Latest.jpg
cp /tmp/Tent2-Latest.jpg /home/mushr/gits/mushr-snapshot/Tent2-Latest.jpg
git add Tent1-Latest.jpg
git add Tent2-Latest.jpg
git commit -m "Update Latest Images"
git push origin

