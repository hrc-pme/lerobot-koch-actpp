#!/bin/bash

####################  ARGS  ###################
CONFIG_FILE_PATH="/root/lerobot/configs/robot/bimanual_koch.yaml"
CAMERA_ON="false"
###############################################

cd /root/lerobot

if [ "$CAMERA_ON" = "true" ]; then
  python3 lerobot/scripts/control_robot.py teleoperate --robot-path "$CONFIG_FILE_PATH" --robot-overrides '~cameras'
else
  python3 lerobot/scripts/control_robot.py teleoperate --robot-path "$CONFIG_FILE_PATH" --robot-overrides '~cameras'
fi
