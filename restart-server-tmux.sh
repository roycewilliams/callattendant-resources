#!/bin/bash

POST_SLEEPSECONDS=7

echo "- Existing tmux sessions:"
/bin/tmux ls
echo ""

echo "- Killing any existing server ..."
/bin/tmux kill-session -t server
echo ""
sleep 1

echo "- Starting server ..."
/bin/tmux new -s "server" -d /home/pi/.callattendant/callattendant-start.sh
echo ""

echo "- Checking status ..."
/bin/tmux ls
echo ""

echo "- Waiting ${POST_SLEEPSECONDS} seconds for startup ..."
sleep ${POST_SLEEPSECONDS}

echo "- Recent log:"
tail /var/log/callattendant.log
echo ""

echo "Current time: $(date)"
echo ""
