FROM ubuntu:20.04 as deps

ENV DEBIAN_FRONTEND="noninteractive" \
    TZ="Europe/Amsterdam"

WORKDIR /usr/test

COPY . .

RUN set -ux \
    && apt-get update -y \
    && apt-get install --no-install-recommends -y \
        build-essential \
        pkg-config \
        cmake \
        automake \
        qtbase5-dev \
        qttools5-dev-tools \
        qttools5-dev \
        libuchardet-dev \
        python3-dev \
        python3-setuptools \
        flex \
        bison \
        libglib2.0-dev \
        libpixman-1-dev \        
        git \
        ca-certificates \
        wget \
        curl \
        flac \
        zzuf

RUN set -ux && apt-get update -y && apt-get install --no-install-recommends -y \
    gcc-$(gcc --version|head -n1|sed 's/.* //'|sed 's/\..*//')-plugin-dev \
    libstdc++-$(gcc --version|head -n1|sed 's/.* //'|sed 's/\..*//')-dev

RUN set -ux && apt-get update -y && apt-get install --no-install-recommends -y  \
    lld-11 llvm-11 llvm-11-dev clang-11

FROM deps as build 

RUN set -ux && cd radamsa && make && make install && cd ..

RUN set -ux && cd AFLplusplus && make distrib && make install && cd ..

RUN set -ux && cd flacon && cmake . && make -j4 && make install && cd ..
