# limesdr_docker
A docker recipe for a full working limesdr suite

## Usage

### Build it yourself:
    comment "RUN volk_profile" in the Dockerfile, so volk profil fits to your cpu
    run ./build.sh to build docker image
    
### Or download it from dockerhub
    docker pull xeniter/ubuntu1804_limesdr_toolkit_v1

### Start Image    
    run ./run.sh to start docker image
    connect limedsdr to your pc
    run "LimeUtil --find"
    it should show something like "[LimeSDR-USB, media=USB 3.0, module=FX3, addr=1d50:6108, serial=...]
    
## 

## Dockerfile

Checks out Source code and builds docker image

Be aware cause its build from latest master git repositories, source code can changed and building complete suite could easily fail with new commits.
Cause gr-lime and gr-osmosdr doesn't find gnuradio in version 3.8 i use brancht for 3.7 and not master for gnuradio.

Contains recipe to build image based on ubuntu 18.04 with follwing software:

    LimeSuite
    SoapySDR
    Volk
    Pothos
    UHD
    GNU Radio
    rtl-sdr
    gr-osmosdr
    gr-limesdr
    gqrx
    
    r-ieee802-11
    gr-foo
    SoapyUHD
    
### Image is available on docker hub:
 https://cloud.docker.com/repository/docker/xeniter/ubuntu1804_limesdr_toolkit_v1/general

### based on (and special thanks to)
 http://blog.reds.ch/?p=43
 https://github.com/sparklespdx/limesdr-toolkit-docker
 
## Usefull commands
    LimeUtil --find
    LimeUtil --update
    gnuradio-companion
    SoapySDRUtil --probe
    SoapySDRUtil --find="driver=lime"
    gqrx (set device string to "soapy=0,driver=lime")
    uhd_find_devices
    LimeQuickTest
    LimeSuiteGUI
    
## usefull links
    https://github.com/emvivre/limesdr_toolbox
    http://blog.reds.ch/?p=43
    https://github.com/sparklespdx/limesdr-toolkit-docker
    
### Docker
    https://hackernoon.com/publish-your-docker-image-to-docker-hub-10b826793faf
    
    
