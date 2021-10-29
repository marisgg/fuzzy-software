FROM ubuntu:latest

ENV DEBIAN_FRONTEND="noninteractive" \
    TZ="Europe/London"

WORKDIR /usr/test

COPY . .

RUN set -ux \
    && apt-get update -y \
    && apt-get install --no-install-recommends -y \
        flac \
        zzuf \
        build-essential \
        pkg-config \
        cmake \
        qtbase5-dev \
        qttools5-dev-tools \
        qttools5-dev \
        libuchardet-dev

RUN set -ux && cd flacon && cmake . && make -j4 && make install && cd ..
