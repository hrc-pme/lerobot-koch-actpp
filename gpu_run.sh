#!/bin/bash

xhost +local:docker
export DISPLAY=:0

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 {armv|armv-rec|actpp-train|actpp-deploy}"
  exit 1
fi

case "$1" in
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