If callattendant console throws "failed to put modem into voice mode" on USR 5637 modem:

Update firmware to latest (USRFlash 1.2.23.EXE)

Typically:

```sudo ./mdmflash -g /dev/ttyACM0 -f svn1223.hex```

Refs:

*  https://groups.io/g/callattendant/topic/usr5637_refuses_to_go_into/80708342?p=
* https://web.archive.org/web/20180314094658/https://support.usr.com/support/product-template.asp?prod=5637
* https://unicom.usr.com/support/5637/5637-drivers.htm

