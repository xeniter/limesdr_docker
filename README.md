# limesdr_docker
A docker recipe for a full working limesdr suite

Checks out Source code and builds docker image with:

Be aware cause its build from latest master git repositories, source code can changed and building complete suite could easily fail with new commits.
Cause gr-lime and gr-osmosdr doesn't find gnuradio in version 3.8 i use brancht for 3.7 and not master for gnuradio.

### based on (and special thanks to)
 http://blog.reds.ch/?p=43
 https://github.com/sparklespdx/limesdr-toolkit-docker

## Dockerfile

Contains recipe to build image based on ubuntu 18.04 with follwing software:

    LimeSuite
    SoapySDR
    Volk
    Pothos
    GNU Radio
    rtl-sdr
    gr-osmosdr
    gr-limesdr
    gqrx
    
    r-ieee802-11
    gr-foo
    

## Usage
    run ./build.sh to build docker image
    run ./run.sh to start docker image
    connect limedsdr to your pc
    run "LimeUtil --find"
    it should show something like "[LimeSDR-USB, media=USB 3.0, module=FX3, addr=1d50:6108, serial=...]

