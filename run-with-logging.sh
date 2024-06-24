#!/bin/bash
#
# 'ts' is usually pare of the 'moreutils' package.

callattendant --config=app.cfg \
        | /bin/ts '[%Y-%m-%d %H:%M:%.S]' \
        | sudo /bin/tee -a /var/log/callattendant.log

