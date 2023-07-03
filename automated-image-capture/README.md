
# Table of Contents

1.  [Software Installation](#org174f0ca)
    1.  [Operating System](#org78977bb)
        1.  [Tent1Pi](#orgb3c0dfb)
        2.  [LightingPi](#orgb3e6948)
        3.  [Tent2Pi](#org14200cd)
2.  [Hardware Installation Guide](#orga6efd23)
    1.  [Focus adjustment](#org7833075)
    2.  [Waterproofing the cameras](#orgb9a1131)
    3.  [Installing the cameras in the tents](#org29d7754)
        1.  [Installing the aluminium mounts](#orga788bbe)
        2.  [Clamping the cameras](#org661947b)
    4.  [Raspberry Pi <-> Camera connection](#org06773e6)
    5.  [Lighting Setup](#org10030a2)

It is reccommended follow the following steps **IN ORDER**.


<a id="org174f0ca"></a>

# Software Installation


<a id="org78977bb"></a>

## Operating System

-   The setup has only been tested with Raspberry Pi OS 32-bit on a
    Rpi4B (the version at the time of writing this guide is:
    <https://downloads.raspberrypi.org/raspios_armhf/images/raspios_armhf-2022-09-26/>)

-   Follow [this guide](https://www.raspberrypi.com/software/) to install your desired OS version.

-   Be sure to enable the SSH daemon and test that you are able to
    remotely log in to each pi using the password you chose during
    install.
    
        sudo systemctl enable sshd.service

-   Please also enable autologin (desktop/TTY) at least for [1.1.3](#org14200cd)
    
    For [1.1.1](#orgb3c0dfb) and [1.1.3](#org14200cd), you must verify whether the cameras are
    functioning using [this guide](https://www.raspberrypi.com/documentation/computers/camera_software.html) (might require a monitor and keyboard
    connected using a micro-HDMI cable).

-   Copy all the (required) scripts from this repository inside a new
    directory "~/scripts" on each pi.

-   Ensure that the latest version of wiringpi is installed on [1.1.1](#orgb3c0dfb)
    and [1.1.3](#org14200cd).
    
        cd /tmp
        wget https://project-downloads.drogon.net/wiringpi-latest.deb
        sudo dpkg -i wiringpi-latest.deb
    
    You might have to install `wget`:
    
        sudo apt install wget

-   Install imagemagick on [1.1.1](#orgb3c0dfb) and [1.1.3](#org14200cd).
    
        sudo apt install imagemagick

-   This folder contains all the scripts required for
    taking images. Briefly summarized, the main scripts are:
    1.  `arducam_multicamera.py` : Library used for taking images using
        the [Arducam Multicamera Board V2.2](https://www.arducam.com/product/multi-camera-v2-1-adapter-raspberry-pi/). This script is based on
        <https://github.com/ArduCAM/RaspberryPi/tree/master/Multi_Camera_Adapter/Multi_Adapter_Board_4Channel>.
        
        To change the way images are captured, you can create/edit the
        camera preset commands `FULL`, `PREVIEW` and `LOW`. More
        specifically, you must change `--awbgain` whenever the colour of
        the lights inside the tents is changed. This is used to manually
        change the colour balance of the images.
    
    2.  `mushrimager-multicam-noremote.sh`,
        `mushrimager-multicam-bothtents.sh` and
        `mushrimager-multicam-previewer.sh` are the currently relevant
        scripts for taking images.
    
    3.  `turn-off-lights.sh` and `turn-on-lights.sh` are used to control
        the lights.

-   Ensure that these scripts are executable
    
        chmod 755 <path to file>.sh
-   Note down the IP address of all raspberry pis.
    
        ip a | grep wlan


<a id="orgb3c0dfb"></a>

### Tent1Pi

Tent1Pi will be connected to the cameras 1A, 1B and 1C in Tent1.

1.  Ensure that `mushrimager-multicam-noremote.sh` is functional.


<a id="orgb3e6948"></a>

### LightingPi

The LightingPi uses a reverse engineered RGB5050 remote configuration
to control the RGB5050 lights in the tents.

1.  Wiring the KY005/KY-022

    Refer to this [manual](https://uelectronics.com/wp-content/uploads/2017/06/KY-005-Joy-IT.pdf) for general instructions, **however,** Lots of
    stuff there about the installation and initial configuration is
    **OUTDATED**. Use this guide instead (last tested 12.12.2022).
    
    Generally, connect 5V and GND on either the KY-022 (when reverse
    engineering a remote) or the KY005 (When using the rpi as a spoof of
    the remote) to a 5V/GND pin on the raspberry pi respectively.
    
    Connect GPIO pin 17 OR 18 on the raspberrypi to the KY-022/KY005
    respectively, depending on which one is needed. The KY-022 is only
    needed for [reverse engineering the remote](#org633485f), and is not needed later.
    
    1.  KY-005/KY-022 Configuration
    
        in /boot/config.txt: uncomment the following lines, and customize the
        pins accordingly, then REBOOT
        
            dtoverlay=gpio-ir,gpio_pin=17	 # for receiving data
            dtoverlay=gpio-ir-tx,gpio_pin=18   # for sending commands
        
        1.  KY-022 Only
        
            Test that the receiver is working:
            
                sudo apt update
                sudo apt install ir-keytable
            
                sudo ir-keytable -c -p all -t
            
            Then use some IR remote to send events to the IR receiver. The events
            should be displayed if all connections are correct.

2.  Installing Lirc

    -   State "LOGGED" from <span class="timestamp-wrapper"><span class="timestamp">[2022-08-18 Thu 14:12] </span></span>   
        As of today, lirc0 defaults to the transmitter, and lirc1 is the
        receiver
    
        sudo apt install lirc
    
    For setting up lirc for future IR transmitters
    Edit /etc/lirc/lirc<sub>options.conf</sub> and change the appropriate lines to
    the following, and REBOOT:
    
        
        ...
        driver	=	default
        ...
        device	=	/dev/lirc0
    
    For the receiver,
    
        sudo systemctl stop lircd.service
        sudo mode2 -d /dev/lirc1

3.  IR Remote Reverse Engineering

        irrecord -d /dev/lirc1 ~/IR-Codes-RGB5050-remote.conf
    
    When prompted, you can use key codes from the following:
    
        irrecord -l 
    
    Copy the file to /etc/lirc/lircd.conf, after backing up the original.

4.  IR Remote spoofing

    1.  To view available commands,
    
            irsend LIST <name of the remote set in lircd.conf> ""
    
    2.  To send a signal ONCE
    
            irsend SEND_ONCE <name of the remote set in lircd.conf> <name of command>
    
    3.  To start sending a signal continuously
    
            irsend SEND_START <name of the remote set in lircd.conf> <name of command>
    
    4.  To stop sending the previous continuous signal
    
            irsend SEND_STOP <name of the remote set in lircd.conf> <name of command>

5.  Current lircd config

    The currently configured /etc/lirc/lircd.conf file is as follows:
    
        
        # Please take the time to finish this file as described in
        # https://sourceforge.net/p/lirc-remotes/wiki/Checklist/
        # and make it available to others by sending it to
        # <lirc@bartelmus.de>
        #
        # This config file was automatically generated
        # using lirc-0.10.1(default) on Thu Aug 18 12:47:46 2022
        # Command line used: -d /dev/lirc1 /home/mushr/IR-codes-RGB5050-remote.conf
        # Kernel version (uname -r): 5.15.56-v7l+
        #
        # Remote name (as of config file): RGB5050remote
        # Brand of remote device, the thing you hold in your hand:
        # Remote device model nr:
        # Remote device info url:
        # Does remote device has a bundled capture device e. g., a
        #     usb dongle? :
        # For bundled USB devices: usb vendor id, product id
        #     and device string (use dmesg or lsusb):
        # Type of device controlled
        #     (TV, VCR, Audio, DVD, Satellite, Cable, HTPC, ...) :
        # Device(s) controlled by this remote:
        
        begin remote
        
          name  RGB5050remote
          bits           24
          flags SPACE_ENC|CONST_LENGTH
          eps            30
          aeps          100
        
          header       9059  4411
          one           647  1577
          zero          647   481
          ptrail        645
          repeat       9050  2157
          pre_data_bits   8
          pre_data       0x0
          gap          107539
          toggle_bit_mask 0x0
          frequency    38000
        
              begin codes
        	  KEY_POWER2               0xF7C03F 0x000000
        	  KEY_POWER                0xF740BF 0x000000
        	  KEY_BRIGHTNESSDOWN       0xF7807F 0x000000
        	  KEY_BRIGHTNESSUP         0xF700FF 0x000000
        	  KEY_PROG1                0xF7E01F 0x000000
        	  KEY_BLUE                 0xF7609F 0x000000
        	  KEY_GREEN                0xF7A05F 0x000000
        	  KEY_RED                  0xF720DF 0x000000
        	  KEY_YELLOW               0xF7906F 0x000000
              end codes
        
        end remote


<a id="org14200cd"></a>

### Tent2Pi

Tent1Pi will be connected to the cameras 1A, 1B and 1C in Tent1, and
also needs to be able to connect to [1.1.1](#orgb3c0dfb) and [1.1.2](#orgb3e6948)

While logged in to this pi,

1.  [Generate an ssh key](https://www.ssh.com/academy/ssh/keygen). e.g,
    
        ssh-keygen -t ed25519

2.  Use [ssh-copy-id](https://www.ssh.com/academy/ssh/keygen) to be able to access the other pis. e.g,
    
        ssh-copy-id ~/ssh/ed25519 pi@<ip address of Tent1Pi>
        ssh-copy-id ~/ssh/ed25519 pi@<ip address of LightingPi>

3.  In `mushrimager-multicam-bothtents.py`, you must change the IP
    addresses and usernames of [1.1.1](#orgb3c0dfb) and [1.1.2](#orgb3e6948) in order for this
    script to function correctly.

4.  Create a file "tucloud.txt" in the same folder with the credentials
    for the tucloud account as follows:
    
        machine tucloud.tu-clausthal.de login <username> password <password>
    
    Custom keys also work.

5.  Ensure that the system time is accurate, as the time is used to
    name the image files.

6.  With [1.1.1](#orgb3c0dfb) and [1.1.2](#orgb3e6948) also configured correctly, test the
    script `mushrimager-multicam-bothtents.py` without any arguments.

7.  Create a [cronjob](https://wiki.archlinux.org/title/Cron) for running this script periodically.
    
        crontab -e
    
    For example, this line will take an image every 15 minutes.
    
        */15    *       *       *       *       /home/pi/scripts/mushrimager-multicam-bothtents.sh

8.  Enable the user crontab as follows (this is the reason autologin is
    necessary):
    
        systemctl --user enable cron.service

9.  Software installation is complete.


<a id="orga6efd23"></a>

# Hardware Installation Guide


<a id="org7833075"></a>

## Focus adjustment

1.  Please refer to [this official guide](https://datasheets.raspberrypi.com/hq-camera/cs-mount-lens-guide.pdf) for attaching the lens to the HQ
    camera board.

2.  Measure the desired focal length needed for the cameras.

3.  The backfocus adjustment and lens focus adjustment must be
    calibrated manually for each camera based on the desired focus
    length. This process is repetitive (trial and error), and would
    require taking multiple images, hence depends upon [1](#org174f0ca).

4.  You can start a live preview for individual cameras using the
    `arducam_multicamera.py` script. (Run `python3
       arducam_multicamera.py -h` for details)


<a id="orgb9a1131"></a>

## Waterproofing the cameras

There are two [3d printed parts](CAD/)used per camera.

-   The **Grey part** is used to hold the lens inside the dome case. (Only
    fits the 120° Wide angle lens). It must be secured with a bit of
    duct tape along it's edges (to create a spongy, but more tight fit)
    inside the [Camera Dome Case](https://amzn.eu/d/iZtZ2rX), aligning the holes for the lens to
    capture images through. A small strip of cardboard might be required
    to fit this inside the dome case. **It is important that this part is
    tightly secured.**

-   The **Green part** keeps the camera board and lens in place at a 90°
    angle. The purpose of the 90° angle placement is to maximize the
    vertical field of view of the captured images, since the tents are
    more tall than they are wide.

-   The HQ camera board should be mounted so that the 200cm flex cable
    exits the camera board at a 90° angle. (Here is a nice [guide](https://thepihut.com/blogs/raspberry-pi-tutorials/how-to-replace-the-raspberry-pi-camera-cable) for
    connecting the cable to the camera board) **PS: Be very careful with
    the black connector**. It is possible to damage it in such a way that
    it does not hold the ribbon cable anymore. For the same reason, do
    not pull too much on the ribbon cable while it is connected.

-   (Optional) A small silica gel pack can be fit right behind the
    camera board to prevent accidental spillage.

-   Use a plastic sheet to waterproof the rest of the camera board from
    the outside (with a healthy amount of duct tape :). Connect one side
    of the 200cm flex cable before sealing it (for obvious reasons).

-   **It is important to not fold/damage the cable in any way.**


<a id="org29d7754"></a>

## Installing the cameras in the tents


<a id="orga788bbe"></a>

### Installing the aluminium mounts

Two aluminium mounts (L=Long & S=short) are used (per tent) to mount
the center facing camera (1.B & 2.B).

1.  The aluminium mounts are currently mounted to the tents using zip
    ties.

2.  They are already screwed in together (thanks to Johannes!)

3.  Mount L needs to be hung vertically, (relatively) in the center of
    each tent. The angle does not have to be perfect.

4.  Mount S needs to be zip tied to either the left or the right side
    of the tent. **PS: It can be beneficial to keep both zip ties a bit
    loose, to be able to move them around while changing camera
    angles.**

5.  Mount S would probably have to be duct-taped to the side of the
    tent to keep it in place.


<a id="org661947b"></a>

### Clamping the cameras

1.  Loosen the ball and socket joint of the [clamp](https://amzn.eu/d/8iBo7e4).
2.  Screw in the clamp to the bottom of the Dome Case. (Do this outside
    the tent, since a bit of rubber residue tends to rub off when doing
    this.)
3.  With the ball and socket joint still slightly loose (**but still
    holding the dome case firmly**), clamp the setup to any desired
    location. You might have to experiment a little bit to get the
    camera lens as far away from the mushrooms inside the tent as
    possible.
4.  Once a desired angle is reached, tighten the ball and socket joint
    using the screw.


<a id="org06773e6"></a>

## Raspberry Pi <-> Camera connection

1.  Thread the ribbon cables through any desired port (tent port).

2.  Connect the Multicamera board ports "A", "B" and "C" to the ribbon
    cables connected to the camera housing labelled "X.A", "X.B", "X.C".
    
    Here, X is either 1 or 2 depending on which tent the camera
    housing is in.

3.  There is a visual hardware assembly guide in drawer "#2".

4.  Power on the raspberry pi.


<a id="org10030a2"></a>

## Lighting Setup

-   Make sure that the RGB5050 lights are set to "yellow".

-   The RGB5050 receiver should also be positioned to be able to receive
    signals from [1.1.2](#orgb3e6948).

