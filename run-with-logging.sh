#!/bin/bash

callattendant --config=app.cfg \
        | /bin/ts '[%Y-%m-%d %H:%M:%.S]' \
        | sudo /bin/tee -a /var/log/callattendant.log
