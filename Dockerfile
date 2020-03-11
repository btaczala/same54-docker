FROM archlinux

RUN pacman -Sy
RUN pacman -S make gcc --noconfirm
RUN pacman -S wget --noconfirm
RUN wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2
RUN tar xvf gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 -C /usr --strip-components=1
