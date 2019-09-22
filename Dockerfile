#LINKS:
#https://wiki.gnuradio.org/index.php/UbuntuInstall#Bionic_Beaver_.2818.04.29
#http://blog.reds.ch/?p=43


FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y dist-upgrade && \
    apt-get -y autoremove && \
    apt-get -y install git && \
    # soapy sdr
    apt-get -y install cmake g++ libpython-dev python-numpy swig && \    
    # lime suite
    # install core library and build dependencies
    apt-get -y install git g++ cmake libsqlite3-dev && \
    # install hardware support dependencies
    apt-get -y install libi2c-dev libusb-1.0-0-dev && \ 
    # install graphics dependencies
    apt-get -y install libwxgtk3.0-dev freeglut3-dev && \ 
    # volk
    apt-get -y install python-mako python-six libboost-all-dev && \
    # uhd
    apt-get -y install libboost-all-dev libusb-1.0-0-dev python3-mako python3-numpy python3-requests python3-setuptools doxygen python-docutils cmake build-essential && \
    # gnureadio (from: # from https://wiki.gnuradio.org/index.php/UbuntuInstall#Bionic_Beaver_.2818.04.29 )
    apt-get -y install liblog4cpp5-dev liblog4cpp5v5 libgmp3-dev python3-click python3-click-plugins g++ libboost-all-dev libgmp-dev swig python3-numpy python3-mako python3-sphinx python3-lxml doxygen libfftw3-dev libcomedi-dev libsdl1.2-dev libgsl-dev libqwt-qt5-dev libqt5opengl5-dev python3-pyqt5 liblog4cpp5-dev libzmq3-dev python3-yaml && \
    # for GNU Radio Companion + WX & GTK GUI
    apt-get -y install python-numpy python-cheetah python-lxml python-gtk2 python-wxgtk3.0 python-numpy python-qt4 python-qwt5-qt4 libqt4-opengl-dev libqwt5-qt4-dev libfontconfig1-dev libxrender-dev libxi-dev && \
    # gr-osmosdr
    apt-get -y install python-cheetah && \
    # gqrx
    apt-get -y install -y qtbase5-dev libqt5svg5-dev && \
    # gr-foo
    apt-get install -y libcppunit-dev && \
    # for limeutil --update, gnuradio
    apt-get -y install wget xterm && \
    # pulseaudio
    apt-get -y install libpulse-dev pulseaudio && \
    # for sound sink (with alsa):
    apt-get -y install alsa-base libasound2 libasound2-dev && \
    # cleanup
    rm -rf /var/lib/apt/lists/*

# SoapySDR
############
WORKDIR /
RUN git clone https://github.com/pothosware/SoapySDR.git

WORKDIR /SoapySDR/build
RUN cmake ..
RUN make -j$(nproc)
RUN make install


# LimeSuite
###############
WORKDIR /
RUN git clone https://github.com/myriadrf/LimeSuite.git

WORKDIR /LimeSuite/build/
RUN cmake ..
RUN make -j$(nproc)
RUN make install


# VOLK
########
WORKDIR /
RUN git clone https://github.com/gnuradio/volk.git

WORKDIR /volk/build/
RUN cmake  ..
RUN make -j$(nproc)
RUN make install
RUN ldconfig
#RUN volk_profile

# pothos
##########
WORKDIR /
RUN git clone --recursive https://github.com/pothosware/PothosCore.git

WORKDIR /PothosCore/build/
RUN pwd
RUN ls -la ../
RUN cmake ..
RUN make -j$(nproc)
RUN make install

# UHD
# https://files.ettus.com/manual/page_build_guide.html
#########################################################
WORKDIR /
RUN git clone --recursive git://github.com/EttusResearch/uhd.git
WORKDIR /uhd/
RUN git submodule init
RUN git submodule update

WORKDIR /uhd/host/build/
RUN cmake ..
RUN make -j$(nproc)
RUN make install
RUN ldconfig


# GNURADIO
############
WORKDIR /
RUN git clone https://github.com/gnuradio/gnuradio.git -b maint-3.7

WORKDIR /gnuradio/build/
RUN cmake -DENABLE_INTERNAL_VOLK=OFF -DCMAKE_BUILD_TYPE=Release ..
RUN make -j$(nproc)
RUN make install


# RTL SDR
###########
WORKDIR /
RUN git clone https://github.com/osmocom/rtl-sdr.git

WORKDIR /rtl-sdr/build/
RUN cmake ..
RUN make -j$(nproc)
RUN make install


# gr-osmosdr
#############
WORKDIR /
RUN git clone https://git.osmocom.org/gr-osmosdr

WORKDIR /gr-osmosdr/build/
RUN cmake ..
RUN make -j$(nproc)
RUN make install


# gr-limesdr
#############
WORKDIR /
RUN git clone https://github.com/myriadrf/gr-limesdr

WORKDIR /gr-limesdr/build/
RUN cmake ..
RUN make -j$(nproc)
RUN make install
RUN ldconfig

# gqrx
#######
WORKDIR /
RUN git clone https://github.com/csete/gqrx.git

WORKDIR /gqrx/build/
RUN cmake ..
RUN make -j$(nproc)
RUN make install


# gr-foo
##########
WORKDIR /
RUN git clone https://github.com/bastibl/gr-foo.git -b maint-3.7

WORKDIR /gr-foo/build/
RUN cmake ..

RUN make -j$(nproc)
RUN make install

RUN ldconfig


# gr-ieee802-11
################
WORKDIR /
RUN git clone https://github.com/bastibl/gr-ieee802-11 -b maint-3.7

WORKDIR /gr-ieee802-11/build/
RUN cmake ..

RUN make -j$(nproc)
RUN make install

RUN ldconfig


# SoapyUHD
###########
WORKDIR /
RUN git clone https://github.com/pothosware/SoapyUHD.git

WORKDIR /SoapyUHD/build/
RUN cmake ..

RUN make -j$(nproc)
RUN make install

WORKDIR /


# pulseaudio
#############
RUN apt-get install libpulse-dev pulseaudio -y

WORKDIR /
RUN git clone https://github.com/bitglue/gr-pulseaudio

WORKDIR /gr-pulseaudio/build/
RUN cmake ..
RUN make -j$(nproc)
RUN make install


