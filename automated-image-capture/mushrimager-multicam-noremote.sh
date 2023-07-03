#!/bin/bash
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
