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


libcamera-still --denoise cdn_hq --awbgain 4.5,3.4 --contrast 1.5 --exposure long -t 3 -n -o /home/mushr2/mushrimg/$FILENAME

echo "Rotating +90°"

convert -rotate "+90" /home/mushr2/mushrimg/$FILENAME /home/mushr2/mushrimg/$FILENAME
