#!/bin/bash

clear

echo "- Existing tmux sessions:"
/bin/tmux ls
echo ""

echo "Listener:"
netstat -an | grep -a LIST | grep -a 5000
echo ""

echo "Config:"
< app.cfg grep -E -v '^#|GPIO|^$|EMAIL|PHONE_DISP|FOLDER|PERMIT_NEXT|PATTERNS_FILE|STATUS_IND|MQTT|TESTING|DEBUG|production|VOICE_MAIL'
echo ""

echo "Recent log:"
tail -n 50 /var/log/callattendant.log \
        | grep -v -E -a 'LED|Going on|Going off|Waiting for|for processing|MSG count: 0' \
        | tail -n 27
echo ""

echo "Current time: $(date)"
echo ""
