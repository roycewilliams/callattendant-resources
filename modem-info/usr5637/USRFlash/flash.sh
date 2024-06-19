#!/bin/bash

FIRMWARE_FILE=svn1223.hex

echo "- Note: third-party script - not part of the official firmware distribution"
echo "- Warning: may require an older Linux kernel (2.6.x)"
echo ""

echo "- Showing recent related dmesg:"
sudo dmesg | grep -E '0baf|Modem|Robotics|tty'
echo ""

echo "- Attempting to guess device name from most recent dmesg ..."
MYDEVICE_RAW=$(sudo dmesg | grep ttyACM | tr '[: ]' '\n' | grep ttyACM | tail -n 1)
if [ -z "${MYDEVICE_RAW}" ]; then
	>&2 echo "- Unable to detect ttyACM device - is a modem present?"
	echo ""
	exit 1
else
	MYDEVICE=/dev/${MYDEVICE_RAW}
fi

test -c "${MYDEVICE}" && echo "- Device ${MYDEVICE} appears to be a character-special device - good."
echo ""

if command -v socat; then
	echo "- Checking ${MYDEVICE} for current firmware version ..."
	echo ATI3 | sudo socat - "${MYDEVICE},crnl" | uniq | head -n 4
else
	>&2 echo "- Unable to check current firmware version - install 'socat'"
	echo ""
fi

echo "- If firmware version is less than V1.2.23, and you need"
echo "- voice functionality, you should proceed with flashing."
echo ""

echo "- Press Enter to flash ${MYDEVICE} with firmware file ${FIRMWARE_FILE},"
echo "- or press Control-C to abort."
read -r blah
echo "$blah" >/dev/null

echo ""
echo "- Initiating flashing of ${MYDEVICE} with firmware file ${FIRMWARE_FILE} ..."
echo "- Command: sudo ./mdmflash -g ${MYDEVICE} -f ${FIRMWARE_FILE}"
sudo ./mdmflash -g "${MYDEVICE}" -f "${FIRMWARE_FILE}"
echo ""
