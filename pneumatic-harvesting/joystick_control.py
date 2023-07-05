#!/usr/bin/python
# coding=utf-8

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


import time
import board
import busio
import adafruit_ads1x15.ads1115 as ADS
from adafruit_ads1x15.analog_in import AnalogIn
import RPi.GPIO as GPIO

BLADE_OUT = 21
BLADE_IN = 20
Button_PIN = 24
ARMED_LED_INDICATOR = 23

ARMED = False
pressed_counter = 0
delayTime = 0.1
armTime = 1 # Seconds
exitTime = 5 # Seconds

i2c = busio.I2C(board.SCL, board.SDA)

ads = ADS.ADS1115(i2c)

GPIO.setwarnings(True)
GPIO.setmode(GPIO.BCM)

time.sleep(2)

GPIO.setup(BLADE_OUT, GPIO.OUT)
GPIO.setup(BLADE_IN, GPIO.OUT)
GPIO.setup(ARMED_LED_INDICATOR, GPIO.OUT)
GPIO.setup(Button_PIN, GPIO.IN, pull_up_down = GPIO.PUD_UP)

# Create single-ended input on channels
chan0 = AnalogIn(ads, ADS.P0)
chan1 = AnalogIn(ads, ADS.P1)
chan2 = AnalogIn(ads, ADS.P2)
chan3 = AnalogIn(ads, ADS.P3)

def turn_both_off():
    GPIO.output(BLADE_OUT, GPIO.HIGH)
    GPIO.output(BLADE_IN, GPIO.HIGH)

def blade_out():
    turn_both_off()
    GPIO.output(BLADE_OUT, GPIO.LOW)

def blade_in():
    turn_both_off()
    GPIO.output(BLADE_IN, GPIO.LOW)

def armed_led_indicator_on():
    GPIO.output(ARMED_LED_INDICATOR, GPIO.HIGH)

def armed_led_indicator_off():
    GPIO.output(ARMED_LED_INDICATOR, GPIO.LOW)

button_pressed = False

turn_both_off()

for _ in range(5):
    armed_led_indicator_on()
    time.sleep(0.2)
    armed_led_indicator_off()
    time.sleep(0.2)

while True:

    time.sleep(delayTime/2)
    #current values are recorded
    X, Y = chan0.voltage, chan1.voltage
    x = '%.2f' % chan0.voltage
    y = '%.2f' % chan1.voltage
 
    # Output to console
    
    if GPIO.input(Button_PIN) == True:
        print ("X-axis:", x, "V, ", "Y-axis:", y, "V, Button: not pressed")
        button_pressed = False
        if pressed_counter*delayTime >= armTime:
            ARMED = not (ARMED)

        pressed_counter = 0
    else:
        print ("X-axis:", x, "V, ", "Y-axis:", y, "V, button: pressed")
        button_pressed = True
        pressed_counter+=1

    print(f"ARMED: {ARMED}")
    print ("---------------------------------------")

    if pressed_counter*delayTime >= exitTime:
        break

    if ARMED:
        armed_led_indicator_on()
        if (abs(X-3.3)<0.01):
            blade_in()

        elif (abs(X-0.0)<0.01):
            blade_out()

        else:
            turn_both_off()
    
    else:
        turn_both_off()
        armed_led_indicator_off()
 
    time.sleep(delayTime/2)


turn_both_off()

for _ in range(2):
    armed_led_indicator_on()
    time.sleep(0.2)
    armed_led_indicator_off()
    time.sleep(0.2)


GPIO.cleanup()
