#!/usr/bin/python3

#  Copyright (c) 2020, Arducam Technology Co., Ltd <http://www.arducam.com>.
#  All rights reserved.
#  
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are met:
#      * Redistributions of source code must retain the above copyright
#        notice, this list of conditions and the following disclaimer.
#      * Redistributions in binary form must reproduce the above copyright
#        notice, this list of conditions and the following disclaimer in the
#        documentation and/or other materials provided with the distribution.
#      * Neither the name of the copyright holder nor the
#        names of its contributors may be used to endorse or promote products
#        derived from this software without specific prior written permission.
#  
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
#  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
#  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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

import RPi.GPIO as gp
import os, sys, argparse

gp.setwarnings(True)
gp.setmode(gp.BOARD)

gp.setup(7, gp.OUT)
gp.setup(11, gp.OUT)
gp.setup(12, gp.OUT)

FULL="libcamera-still --denoise cdn_hq --awbgain 4.5,3.4 --contrast 1.5 --exposure long -t 3 -n -o {0}"

PREVIEW="libcamera-still -t 0"

LOW="libcamera-still --width 640 --height 480 --denoise cdn_hq --contrast 1.5 --exposure long -t 1 -n -o {0}"

def capture(num, filename, preset=FULL):
    if(num=="A"):
        print('Capturing image from Camera A') 
        i2c = "/usr/sbin/i2cset -y 1 0x70 0x00 0x04"
        os.system(i2c)
        gp.output(7, False)
        gp.output(11, False)
        gp.output(12, True)

    elif(num=="B"):
        print('Capturing image from Camera B') 
        i2c = "/usr/sbin/i2cset -y 1 0x70 0x00 0x05"
        os.system(i2c)
        gp.output(7, True)
        gp.output(11, False)
        gp.output(12, True)

    elif(num=="C"):
        print('Capturing image from Camera C') 
        i2c = "/usr/sbin/i2cset -y 1 0x70 0x00 0x06"
        os.system(i2c)
        gp.output(7, False)
        gp.output(11, True)
        gp.output(12, False)
        

    elif(num=="D"):
        print('Capturing image from Camera D') 
        i2c = "/usr/sbin/i2cset -y 1 0x70 0x00 0x07"
        os.system(i2c)
        gp.output(7, True)
        gp.output(11, True)
        gp.output(12, False)
        
    os.system(preset.format(filename))

if __name__=="__main__":
    parser = argparse.ArgumentParser(description="Wrapper script to capture images using the Arducam Multi-Camera V2.2 board")
    parser.add_argument("-c", "--camera", choices=["A", "B", "C", "D"], required=True)
    parser.add_argument("-o", "--output-file", type=str, help="Output file path", required=True)
    parser.add_argument("-p", "--camera-preset", choices=["FULL", "LOW", "PREVIEW"], required=True)

    args = parser.parse_args()
    capture(args.camera, args.output_file, {"FULL":FULL, "LOW":LOW, "PREVIEW":PREVIEW}[args.camera_preset])
