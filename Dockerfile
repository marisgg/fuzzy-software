FROM ubuntu:latest

ENV DEBIAN_FRONTEND="noninteractive" \
    TZ="Europe/London"

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

RUN set -ux && pwd && cd flacon && cmake . && make -j4 && make install && cd ..
# RUN cd ../zzuf && ./configure && make -j4 && make install & cd ..

CMD zzuf -x -s 0:100 -C 100 flacon -s orig.out
