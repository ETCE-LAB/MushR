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
