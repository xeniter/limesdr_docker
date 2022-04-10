#!/bin/bash

set -x

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
  -v /home/nios/:/home/nios/ \
  xeniter/ubuntu2004_limesdr_toolkit_gr3-8_spectogram:latest /bin/bash
  
  
  #xeniter/ubuntu2004_limesdr_toolkit_gr3-8:latest "$@"
  #  limesdr-toolkit:latest "$@"
  
  
  #xeniter/ubuntu2004_limesdr_toolkit_gr3-8

