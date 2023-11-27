FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get upgrade -y

# timezone setting
RUN apt-get install -y tzdata
ENV TZ Asia/Tokyo
RUN unset ${DEBIAN_FRONTEND}

# base lib
RUN apt-get install -y build-essential tar zip unzip vim git curl
RUN apt-get install -y gcc g++ cmake make
RUN apt-get install -y python3.8

# openmvg
RUN mkdir /workspace
WORKDIR /workspace
RUN apt-get install -y libpng-dev libjpeg-dev libtiff-dev libxxf86vm1 libxxf86vm-dev libxi-dev libxrandr-dev
RUN git clone --recursive https://github.com/openMVG/openMVG.git
RUN mkdir openMVG_build
WORKDIR /workspace/openMVG_build
RUN cmake -DCMAKE_BUILD_TYPE=RELEASE . ../openMVG/src/
RUN cmake --build . --target install

# meshlab
RUN apt-get install -y meshlab

# eigen3
RUN apt-get install -y bison pkg-config
# RUN apt-get install -y libeigen3-dev
WORKDIR /workspace
RUN git clone https://gitlab.com/libeigen/eigen.git -b 3.4.0
RUN mkdir /workspace/eigen_build
WORKDIR /workspace/eigen_build
RUN cmake . ../eigen
RUN make && make install

# ceres-solver
WORKDIR /workspace
RUN apt-get install -y libgoogle-glog-dev libgflags-dev libatlas-base-dev libsuitesparse-dev
RUN git clone https://ceres-solver.googlesource.com/ceres-solver -b 2.2.0
RUN mkdir ceres_build
WORKDIR /workspace/ceres_build
RUN cmake . ../ceres-solver
RUN make && make install

# opencv4
# RUN apt-get install -y python3-distutils libxtst-dev libdbus-1-dev
RUN apt-get install -y libopencv-dev

# cgal
# RUN apt-get install -y autoconf libtool
RUN apt-get install -y libcgal-dev

# boost
# RUN apt-get install -y autoconf-archive
RUN apt-get install -y libboost-all-dev

# vcglib
WORKDIR /workspace
RUN git clone https://github.com/cdcseacave/VCG.git

# OpenMVS build
WORKDIR /workspace
RUN apt-get install -y libxmu-dev libxi-dev libgl-dev xorg-dev libglu1-mesa-dev libxinerama-dev
RUN git clone --recurse-submodules https://github.com/cdcseacave/openMVS.git -b develop
RUN mkdir /workspace/openMVS_build
WORKDIR /workspace/openMVS_build
RUN cmake \
   . ../openMVS \
   -DOpenMVS_USE_CUDA=OFF \
   -DVCG_ROOT=/workspace/VCG \
   -DCMAKE_BUILD_TYPE=Release \
   -DCMAKE_CXX_COMPILER=/usr/bin/g++-9 \
   -DCMAKE_C_COMPILER=/usr/bin/gcc-9
RUN make && make install