FROM alpine
RUN apk add build-base --no-cache
RUN apk add mpc1-dev --no-cache
RUN apk add gmp-dev --no-cache
RUN apk add mpfr-dev --no-cache
RUN apk add texinfo --no-cache

ADD build_binutils.sh /
ADD build_gdb.sh /


RUN chmod +x /build_binutils.sh
RUN /build_binutils.sh

RUN wget http://mirror.linux-ia64.org/gnu/gcc/releases/gcc-9.2.0/gcc-9.2.0.tar.xz
RUN tar xf gcc-9.2.0.tar.xz

RUN mkdir /tmp/gcc-avr && cd /tmp/gcc-avr && /gcc-9.2.0/configure --prefix=/usr --target=avr --enable-languages=c,c++ --disable-nls --disable-libssp --with-dwarf2
RUN cd /tmp/gcc-avr && make -j$(nproc)
RUN cd /tmp/gcc-avr && make -j$(nproc) install
RUN avr-g++ --version


RUN chmod +x /build_gdb.sh
RUN /build_gdb.sh
