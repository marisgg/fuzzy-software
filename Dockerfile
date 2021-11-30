# Running on Ubuntu 20.04 LTS.
FROM ubuntu:20.04 as deps

# Environment variables for apt-get.
ENV DEBIAN_FRONTEND="noninteractive" \
    TZ="Europe/Amsterdam"

# Define clang version to use.
ARG CLANG_VERSION=12

# Environment for clang 11
ENV CMAKE_C_COMPILER=clang-${CLANG_VERSION} \
    CMAKE_CXX_COMPILER=clang++-${CLANG_VERSION} \
    LLVM_CONFIG=llvm-config-${CLANG_VERSION}

# We are running as root still.
WORKDIR /usr/working

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
        libtag1-dev \
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
    lld-${CLANG_VERSION} llvm-${CLANG_VERSION} llvm-${CLANG_VERSION}-dev clang-${CLANG_VERSION}

FROM deps as build 

# Copy git checkout to docker file system.
COPY . .

# Radamsa
RUN set -ux && cd radamsa && make && make install && cd .. && rm -Rf radamsa

# Flacon without AFL++ and AddressSanitizer
RUN set -ux && cd flacon && cmake . && make -j4 && make install && cd ..
