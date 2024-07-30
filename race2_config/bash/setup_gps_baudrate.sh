#!/bin/bash

echo "Stopping GPSD!"
sudo systemctl stop gpsd.socket
sleep 2

echo "Setup USB0 baud rate initiated!"
sudo stty -F /dev/ttyUSB0 9600
sleep 2

echo "Restarting GPSD!"
sudo systemctl restart gpsd.socket

echo "All Done!"
echo " Checking gpsd: cgps -s"
echo " Checking chrony: watch -n -0.1 chronyc sources -v"
echo "Exitting now!"
exit