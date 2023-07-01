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

import cv2
import numpy as np
import sys, argparse
import tqdm

CACHE_NUM=24*10 # Keep the images from the last 10 days

def brightness_of(filepath):
    # TODO
    return 11

def block_until_brightness(threshold=10, max_wait=10):
    """Block execution until brightness reaches at least `threshold`,
    or until `max_wait` seconds have elapsed

    """
    import arducam_multicamera
    import datetime

    wait_time = datetime.timedelta()
    time = datetime.datetime.now()
    while(wait_time.seconds < max_wait):
        arducam_multicamera.capture("A",
                                    "/tmp/temp-brightness.jpg",
                                    preset=arducam_multicamera.LOW):
        
        if brightness_of("/tmp/temp-brightness.jpg") > threshold:
            return True

        time2=datetime.datetime.now()
        wait_time += time2-time
        time=time2

    return False

def 
