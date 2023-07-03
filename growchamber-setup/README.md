# Environment Monitor for MushR  with Humidity controller, Temperature Controller, and Cheese Effect while capturing Photo 

Mushrooms grow in a humid and warm environment. for optimal growth of mushrooms humidity and temperature has to be maintained at higher levels to support proper growth.
 
To control humidity and Temperature, MushR used Mycodo (https://github.com/kizniche/Mycodo)  with a mushr specific feature we call, "Cheese Effect". This is implemented to remove noise from the captured photo caused due to high humidity inside the tent. MushR cameras capture images every hour so this effect is effective from 10 minutes before the turn of the hour to 2 minutes past. Also see (https://github.com/ETCE-LAB/MushR/tree/grow-chamber-documentation#automated-image-capture).

#### Required Hardware


1. Raspberry pi 4 model b, Raspberry pi case
2. SD card 8-32 Gb,
3. Two DHT22 Sensors ( for 2 tents),
4.  Humidifiers, Fans, water Tanks (60ltrs)
5.  Grow tent Heaters,
6.  Smart plugs / relays
7.  Jumper cables 
8.  Inkbird * 2 

Step 1.
Installing Raspberry Pi OS using the following official raspberry pi website

   [Raspberrypi official Website](https://www.raspberrypi.com/documentation/computers/getting-started.html)

step 2.

 Install latest version of mycodo into the raspian os from official mycodo github repository

   [MyCodo official Website](https://github.com/kizniche/Mycodo)

step 3.
  
  connect DHT 22 sensors using following circuit diagram
  
   ![image](https://user-images.githubusercontent.com/121457303/213936615-b075f605-b585-4e9d-a627-f37e617ed990.png)

step 4. 
  
  Configure the DHT22 sensors as Inputs in the mycodo using the following tutorial
  
   [click here](input/readme.md)
  
Step 5
   Configure the smart plugs as outputs in the mycodo using the following tutorial
   
   [click here](smartplugs/readme.md)
   
   Smart plugs are used for turning on/off the humidifiers when required
   
Step 6

   try reading the simple algorithm before you start the next tutorial
   [click here](overview%20algo/readme.md)
   
   Step 6.1 
   
   Configure humidity control as function in mycodo
     
   [click here](function/readme.md)
    

#### List of Contributors

1. Harish Gundelli
