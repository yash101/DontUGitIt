# WiFind
Find every device around you - generate a 3D pointmap containing a list of devices near you, determine which devices are stationary, and use known stationary WiFi devices to localize yourself.

## How Does WiFind work
WiFind works by triangulating each device. It uses a GPS antenna along with an inertial motion unit (IMU) in order to determine the exact position of the device containing the WiFi antenna. The WiFi antenna uses promiscuous capture mode in order to capture packets from devices around you. It thereafter, determines the MAC address of the device and uses it as an UUID. As you move the WIFI antenna around, you continue to capture packets from the new location(s). From each locations you receive a packet, the location is captured along with the signal strength, and a simple algorithm is used to calculate the exact location of the device.

As the device sends more packets and/or the WiFi receiver is moved around, the accuracy of the device location increases.

To determine if a device is stationery or not, the algorithm is constantly triangulating the position of the device. However, if the triangulated location begins to change (statistically), we can assume the device is not stationary.

## What Does this Repository Contain
This repository contains the software required to do all, mentioned above, schematics for position-sensing hardware and an interface to use this software to analyze issues in an infrastructure.\


## IMPORTANT:
This software will collect and analyze a SHIT ton of data, so beware when using this. That said, it only saves a small percentage of the data received and processed.

## Goals:
- Create a colorful and cool map that shows all WiFi devices, separated devices from routers (different colors), determines the packet rate (bandwidth consumption) of each device, defines dead zones, locations with a WiFi density, determine popular WiFi channels in different places (taking into account the actual packet rate as compared to something like WiFi Analyzer on Android).

## Is GPS Required?:
No, GPS is not required. It's used for calibrating the IMU with position data, as well as reducing IMU drift. It's also useful for automatic graphing. It could be possible for a button to be pressed to calibrate the position of the sensor, and apply a precise location to it.
