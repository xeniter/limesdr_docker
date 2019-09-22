#!/bin/bash

# hack but works
xhost +

sudo docker run \
  -it --rm --privileged \
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native \
  -v /dev/bus/usb:/dev/bus/usb \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -e DISPLAY=unix$DISPLAY \
  -u root \
  -v /run/user/1000/pulse:/run/user/1000/pulse \
  -v /home/nios/Desktop/LIME/limesdr_docker/mnt/:/root/ \
  limesdr-toolkit:latest "$@"

