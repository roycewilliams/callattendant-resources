#!/bin/bash

cd /home/pi
source venv/bin/activate
cd .callattendant/
./run-with-logging.sh
