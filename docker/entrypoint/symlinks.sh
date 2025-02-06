#!/bin/bash

# Create symlinks for the serial ports in the docker container
ln -sf /dev/ttyACM3 /dev/ttykoch_left_follower
ln -sf /dev/ttyACM0 /dev/ttykoch_left_leader
ln -sf /dev/ttyACM1 /dev/ttykoch_right_follower
ln -sf /dev/ttyACM2 /dev/ttykoch_right_leader

exec "$@"