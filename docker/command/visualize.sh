#!/bin/bash

####################  ARGS  ###################
# store your Hugging Face repository name
# HF_USER=$(huggingface-cli whoami | head -n 1)
HF_USER="pomelo925"
REPO_NAME="koch_test"
###############################################

export PYTHONPATH=/usr/local/lib/python3.10/site-packages:$PYTHONPATH

cd /root/lerobot

python3 lerobot/scripts/visualize_dataset_html.py \
  --root data \
  --repo-id ${HF_USER}/${REPO_NAME}