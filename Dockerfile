#LINKS:
#https://wiki.gnuradio.org/index.php/UbuntuInstall#Focal_Fossa_.2820.04.29
#http://blog.reds.ch/?p=43


FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y dist-upgrade && \
    apt-get -y autoremove && \
    apt-get -y install git && \
    # soapy sdr
    apt-get -y install cmake g++ libpython2-dev python-numpy swig && \    
    # lime suite
    # install core library and build dependencies
    apt-get -y install git g++ cmake libsqlite3-dev && \
    # install hardware support dependencies
    apt-get -y install libi2c-dev libusb-1.0-0-dev && \ 
    # install graphics dependencies
    apt-get -y install libwxgtk3.0-gtk3-dev freeglut3-dev && \ 
    # volk
    apt-get -y install python-mako python-six libboost-all-dev && \
    # uhd
    apt-get -y install libboost-all-dev libusb-1.0-0-dev python3-mako python3-numpy python3-requests python3-setuptools doxygen python-docutils cmake build-essential && \
    # pothos
    apt-get -y install \
    libnuma-dev cmake g++ \
    libpython-all-dev python-numpy \
    qtbase5-dev libqt5svg5-dev libqt5opengl5-dev libqwt-qt5-dev \
    portaudio19-dev libjack-jackd2-dev \
    graphviz && \
    # https://wiki.gnuradio.org/index.php/UbuntuInstall#Focal_Fossa_.2820.04.29
    apt -y install git cmake g++ libboost-all-dev libgmp-dev swig python3-numpy python3-mako python3-sphinx python3-lxml doxygen libfftw3-dev libsdl1.2-dev libgsl-dev libqwt-qt5-dev libqt5opengl5-dev python3-pyqt5 liblog4cpp5-dev libzmq3-dev python3-yaml python3-click python3-click-plugins python3-zmq python3-scipy python3-gi python3-gi-cairo gobject-introspection gir1.2-gtk-3.0 && \
    
    # for GNU Radio Companion + WX & GTK GUI
    apt-get -y install python-numpy python-cheetah python-lxml python-wxgtk3.0 python-numpy libqt5opengl5-dev libqwt-qt5-dev libfontconfig1-dev libxrender-dev libxi-dev && \
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
    # networksniffer
    apt-get -y install wireshark && \   
    # texteditor
    apt-get -y install kate && \    
    # cleanup
    rm -rf /var/lib/apt/lists/*

# pulseaudio
#############
RUN apt-get install libpulse-dev pulseaudio -y

# for VI
RUN apt-get update && apt-get install vim -y

# for spectogram python demo
RUN apt-get install python3-matplotlib -y
RUN apt-get install python3-skimage -y

# SoapySDR
############
WORKDIR /
RUN git clone https://github.com/pothosware/SoapySDR.git

WORKDIR /SoapySDR/build
RUN cmake ..
RUN make -j$(nproc)
RUN make install

# Soapy Remote
###############
WORKDIR /
RUN git clone https://github.com/pothosware/SoapyRemote.git
WORKDIR /SoapyRemote/build/
RUN cmake ..
RUN make -j$(nproc)
RUN make install


# gqrx for spectrogram
#######################
WORKDIR /
RUN git clone https://github.com/gasparka/gqrx

WORKDIR /gqrx/build/
RUN cmake .. -DCMAKE_CXX_STANDARD_LIBRARIES="-lSoapySDR"
RUN make -j$(nproc)
RUN make install

# LimeSuite for spectrogram
#############################
WORKDIR /
RUN git clone https://github.com/xeniter/LimeSuite.git

WORKDIR /LimeSuite/
# 40mhz lime mini version
#RUN git checkout 3e778bb8af8e89ee208135871d51c67af96e7f23
RUN git checkout fpga_fft

WORKDIR /LimeSuite/build/
RUN cmake ..
RUN make -j$(nproc)
RUN make install

RUN ldconfig

# entrypoint
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
