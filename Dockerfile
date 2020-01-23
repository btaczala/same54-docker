FROM alpine

RUN wget http://mirror.linux-ia64.org/gnu/gcc/releases/gcc-9.2.0/gcc-9.2.0.tar.xz

RUN tar xf gcc-9.2.0.tar.xz
RUN ls && pwd
RUN apk add build-base --no-cache

RUN wget https://ftp.gnu.org/gnu/binutils/binutils-2.33.1.tar.xz
RUN tar xf binutils-2.33.1.tar.xz
RUN mkdir /tmp/binutils-avr && cd /tmp/binutils-avr && /binutils-2.33.1/configure --prefix=/usr --target=avr --disable-nls
RUN cd /tmp/binutils-avr && make -j$(nproc)
RUN cd /tmp/binutils-avr && make -j$(nproc) install
RUN ls /usr/bin/avr-*

RUN apk add mpc1-dev --no-cache
RUN apk add gmp-dev --no-cache
RUN apk add mpfr-dev --no-cache
RUN apk add texinfo --no-cache
RUN mkdir /tmp/gcc-avr && cd /tmp/gcc-avr && /gcc-9.2.0/configure --prefix=/usr --target=avr --enable-languages=c,c++ --disable-nls --disable-libssp --with-dwarf2
RUN cd /tmp/gcc-avr && make -j$(nproc)
RUN cd /tmp/gcc-avr && make -j$(nproc) install
RUN avr-g++ --version


ADD build_gdb.sh /
RUN /build_gdb.sh