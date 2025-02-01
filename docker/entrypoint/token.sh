#!/bin/bash

## NOTE: Please make sure to first set the
##       HUGGINGFACE_TOKEN in the .env file
##       if you need to push dataset to the Hugging Face Hub

# Load args from .env
ENV_FILE_PATH="/root/entrypoint/.env"
export $(grep -v '^#' ${ENV_FILE_PATH} | xargs)

# Check if the token is set
if [ -z "$HUGGINGFACE_TOKEN" ]; then
  echo "Error: HUGGINGFACE_TOKEN is not set. Please create a .env file."
  exit 1
fi

# mark git directory safe
git config --global --add safe.directory /root/lerobot

# set git credential
git config --global credential.helper store

# login
huggingface-cli login --token ${HUGGINGFACE_TOKEN} --add-to-git-credential

exec "$@"