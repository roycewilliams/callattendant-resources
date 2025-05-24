This is a mirror of the original firmware distribution that adds voice capabilities to the USR 5637 USB "hard" modem.

If the callattendant console throws a "failed to put modem into voice mode" error on USR 5637 modem, update firmware to latest.

On Windows, use "USRFlash 1.2.23.EXE".

On Linux, flashing would typically look like this:

```sudo ./mdmflash -g /dev/ttyACM0 -f svn1223.hex```

A flashing helper script that I (Royce) wrote --  `flash.sh` -- is also included. It's what I use, but the Linux binary for flashing requires a 2.6.x Linux kernel, so I run it on an old spare laptop with no network connectivity.

Refs:

* https://groups.io/g/callattendant/topic/usr5637_refuses_to_go_into/80708342?p=
* https://web.archive.org/web/20180314094658/https://support.usr.com/support/product-template.asp?prod=5637
* https://unicom.usr.com/support/5637/5637-drivers.htm

