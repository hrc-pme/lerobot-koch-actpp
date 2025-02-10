#!/bin/bash

####################  ARGS  ###################
# store your Hugging Face repository name
# HF_USER=$(huggingface-cli whoami | head -n 1)
HF_USER="pomelo925"
REPO_NAME="koch_test"
TAG="test"

CONFIG_FILE_PATH="/root/lerobot/lerobot/configs/robot/koch_bimanual.yaml"

FPS=30
WARMUP_TIME_S=2
EPISODE_TIME_S=6
RESET_TIME_S=10
NUM_EPISODES=1
###############################################

export PYTHONPATH=/usr/local/lib/python3.10/site-packages:$PYTHONPATH

cd /root/lerobot

python3 lerobot/scripts/control_robot.py record \
  --robot-path $CONFIG_FILE_PATH \
  --fps $FPS \
  --repo-id $HF_USER/$REPO_NAME \
  --tags $TAG \
  --warmup-time-s $WARMUP_TIME_S \
  --episode-time-s $EPISODE_TIME_S \
  --reset-time-s $RESET_TIME_S \
  --num-episodes $NUM_EPISODES  