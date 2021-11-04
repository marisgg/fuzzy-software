# Running on Ubuntu 20.04 LTS.
FROM ubuntu:20.04 as deps

# Environment variables for apt-get.
ENV DEBIAN_FRONTEND="noninteractive" \
    TZ="Europe/Amsterdam"

# Environment for clang 11
ENV CMAKE_C_COMPILER=clang-11 \
    CMAKE_CXX_COMPILER=clang++-11

# We are running as root still.
WORKDIR /usr/working

# Copy git checkout to docker file system.
COPY . .

# Gather dependencies (Flacon/radamsa/zzuf/AFL++).
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

# Get GCC plugin dev and libstdc++-dev packages for GCC version (9).
RUN set -ux && apt-get update -y && apt-get install --no-install-recommends -y \
    gcc-$(gcc --version|head -n1|sed 's/.* //'|sed 's/\..*//')-plugin-dev \
    libstdc++-$(gcc --version|head -n1|sed 's/.* //'|sed 's/\..*//')-dev

# Get llvm 11 for AFL++ and create symlink for the config binary.
RUN set -ux && apt-get update -y && apt-get install --no-install-recommends -y  \
    lld-11 llvm-11 llvm-11-dev clang-11 && \
    ln -s /usr/bin/llvm-config-11 /usr/bin/llvm-config

FROM deps as build 

# Radamsa
RUN set -ux && cd radamsa && make && make install && cd .. && rm -Rf radamsa

# AFL++
RUN set -ux && cd AFLplusplus && make distrib && make install && cd ..

# Flacon (TODO: Compile with AFL++)
RUN set -ux && cd flacon && cmake . && make -j4 && make install && cd ..
