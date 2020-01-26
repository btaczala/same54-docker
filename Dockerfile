FROM alpine

RUN apk add build-base --no-cache

RUN apk add mpc1-dev --no-cache
RUN apk add gmp-dev --no-cache
RUN apk add mpfr-dev --no-cache
RUN apk add texinfo --no-cache

# binutils
RUN wget https://ftp.gnu.org/gnu/binutils/binutils-2.33.1.tar.xz
RUN tar xf binutils-2.33.1.tar.xz
RUN echo "Building binutils"
RUN mkdir /tmp/binutils-avr && cd /tmp/binutils-avr && /binutils-2.33.1/configure --prefix=/usr --target=avr --disable-nls > /dev/null
RUN cd /tmp/binutils-avr && make -j$(nproc) > /dev/null
RUN cd /tmp/binutils-avr && make -j$(nproc) install > /dev/null

# GCC
RUN wget http://mirror.linux-ia64.org/gnu/gcc/releases/gcc-9.2.0/gcc-9.2.0.tar.xz
RUN tar xf gcc-9.2.0.tar.xz
RUN echo "Building gcc"
RUN mkdir /tmp/gcc-avr && cd /tmp/gcc-avr && /gcc-9.2.0/configure --prefix=/usr --target=avr --enable-languages=c,c++ --disable-nls --disable-libssp --with-dwarf2 > /dev/null
RUN cd /tmp/gcc-avr && make -j$(nproc) > /dev/null
RUN cd /tmp/gcc-avr && make -j$(nproc) install > /dev/null
RUN avr-g++ --version

# building GDB
RUN cd /tmp && wget https://ftp.gnu.org/gnu/gdb/gdb-8.3.tar.xz && tar xf gdb-8.3.tar.xz

RUN echo "Building gdb"
RUN mkdir /tmp/gdb-build && cd /tmp/gdb-build && /tmp/gdb-8.3/configure --prefix=/usr --target=avr > /dev/null
RUN cd /tmp/gdb-build && make -j$(nproc) > /dev/null
RUN cd /tmp/gdb-build && make install -j$(nproc) > /dev/null

RUN apk add cmake --no-cache

RUN rm /tmp/gdb-build -rf
RUN rm /tmp/gcc-avr -rf
RUN rm /tmp/binutils-avr -rf
