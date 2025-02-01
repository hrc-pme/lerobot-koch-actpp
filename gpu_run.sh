#!/bin/bash

# add docker to xhost
xhost +local:docker

# set display
export DISPLAY=:0

# make all entrypoint files executable
chmod +x docker/entrypoint/*

# check validity of args
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 {raw|armv|armv-rec|actpp-train|actpp-deploy}"
  exit 1
fi

# run docker compose
case "$1" in
  raw)
    cd docker/gpu
    docker compose -p koch-actpp up raw -d
    ;;

  armv)
    cd docker/gpu
    docker compose -p koch-actpp up armv -d
    ;;

  armv-rec)
    cd docker/gpu
    docker compose -p koch-actpp up armv-rec -d
    ;;

  actpp-train)
    cd docker/gpu
    docker compose -p koch-actpp up actpp-train -d
    ;;

  actpp-deploy)
    cd docker/gpu
    docker compose -p koch-actpp up actpp-deploy -d
    ;;
  *)
    echo "Invalid argument: $1"
    echo "Usage: $0 {armv|armv-rec|actpp-train|actpp-deploy}"
    exit 1
    ;;
esac