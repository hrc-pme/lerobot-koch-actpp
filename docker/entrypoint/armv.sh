#!/bin/bash

####################  ARGS  ###################
CONFIG_FILE_PATH="/root/lerobot/lerobot/configs/robot/koch_bimanual.yaml"
CAMERA_ON="false"
###############################################

export PYTHONPATH=/usr/local/lib/python3.10/site-packages:$PYTHONPATH

cd /root/lerobot

if [ "$CAMERA_ON" = "true" ]; then
  python3 lerobot/scripts/control_robot.py teleoperate \
    --robot-path $CONFIG_FILE_PATH
else
  python3 lerobot/scripts/control_robot.py teleoperate \
    --robot-path $CONFIG_FILE_PATH \
    --robot-overrides '~cameras'
fi