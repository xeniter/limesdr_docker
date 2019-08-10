#LINKS:
#https://wiki.gnuradio.org/index.php/UbuntuInstall#Bionic_Beaver_.2818.04.29
#http://blog.reds.ch/?p=43


FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y dist-upgrade && \
    apt-get -y autoremove

RUN apt-get -y install git

# SoapySDR
############
RUN apt-get -y install cmake g++ libpython-dev python-numpy swig
RUN git clone https://github.com/pothosware/SoapySDR.git

WORKDIR /SoapySDR/build
RUN cmake ..
RUN make -j$(nproc)
RUN make install


# LimeSuite
###############

#install core library and build dependencies
RUN apt-get -y install git g++ cmake libsqlite3-dev
 
#install hardware support dependencies
RUN apt-get -y install libi2c-dev libusb-1.0-0-dev
 
#install graphics dependencies
RUN apt-get -y install libwxgtk3.0-dev freeglut3-dev

WORKDIR /
RUN git clone https://github.com/myriadrf/LimeSuite.git

WORKDIR /LimeSuite/build/
RUN cmake ..
RUN make -j$(nproc)
RUN make install


# VOLK
########
RUN apt-get -y install python-mako
RUN apt-get -y install python-six
RUN apt-get -y install libboost-all-dev

WORKDIR /
RUN git clone https://github.com/gnuradio/volk.git

WORKDIR /volk/build/
RUN cmake  ..
RUN make -j$(nproc)
RUN make install
RUN ldconfig
RUN volk_profile

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

# GNURADIO
############
RUN apt-get install -y liblog4cpp5-dev
RUN apt-get install -y liblog4cpp5v5
RUN apt-get install -y libgmp3-dev
RUN apt-get install -y python3-click
RUN apt-get install -y python3-click-plugins
# from https://wiki.gnuradio.org/index.php/UbuntuInstall#Bionic_Beaver_.2818.04.29
RUN apt-get install -y g++ libboost-all-dev libgmp-dev swig python3-numpy python3-mako python3-sphinx python3-lxml doxygen libfftw3-dev libcomedi-dev libsdl1.2-dev libgsl-dev libqwt-qt5-dev libqt5opengl5-dev python3-pyqt5 liblog4cpp5-dev libzmq3-dev python3-yaml 

# for GNU Radio Companion
RUN apt-get install -y python-numpy python-cheetah python-lxml python-gtk2
# for WX GUI
RUN apt-get install -y python-wxgtk3.0 python-numpy
# for QT GUI
RUN apt-get install -y python-qt4 python-qwt5-qt4 libqt4-opengl-dev libqwt5-qt4-dev libfontconfig1-dev libxrender-dev libxi-dev


WORKDIR /
#RUN git clone  --recursive https://github.com/gnuradio/gnuradio.git -b maint-3.7
RUN git clone https://github.com/gnuradio/gnuradio.git -b maint-3.7
#RUN git clone https://github.com/gnuradio/gnuradio.git
#RUN git clone --recursive https://github.com/gnuradio/gnuradio.git


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
RUN apt-get install -y python-cheetah

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
RUN apt-get install -y qtbase5-dev
RUN apt-get install -y libqt5svg5-dev

WORKDIR /
RUN git clone https://github.com/csete/gqrx.git

WORKDIR /gqrx/build/
RUN cmake ..
RUN make -j$(nproc)
RUN make install

# gr-foo
##########
RUN apt-get install -y libcppunit-dev

WORKDIR /
RUN git clone https://github.com/bastibl/gr-foo.git -b maint-3.7

WORKDIR /gr-foo/build/
RUN cmake ..
RUN make -j$(nproc)
RUN make install
RUN ldconfig

# gr-ieee802-11
################
WORKDIR /
RUN git clone https://github.com/bastibl/gr-ieee802-11 -b maint-3.7

WORKDIR /gr-ieee802-11/build/
RUN cmake ..
RUN make -j$(nproc)
RUN make install
RUN ldconfig


WORKDIR /

# for limeutil --update
RUN apt-get install -y wget



