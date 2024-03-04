#!/bin/bash

echo "Local script - not part of the firmware distribution."
echo ""

echo "Showing recent related dmesg:"
dmesg | grep -E '0baf|Modem|Robotics|tty'
echo ""

echo "Crude check for current firmware version:"
echo ATI3 | sudo socat - /dev/ttyACM0,crnl | uniq | head -n 4
echo ""

echo "If firmware version is less than V1.2.23, and you need"
echo "voice functionality, you should proceed with flashing."
echo ""

echo "Press Enter to flash /dev/ttyACM0 with svn1223.hex."
echo "Press Control-Break to abort."
read -r blah
echo "$blah" >/dev/null

echo ""
echo "Initiating flashing ..."
sudo ./mdmflash -g /dev/ttyACM0 -f svn1223.hex

