#!/bin/sh

gdb_dir="/tmp/gdb"
gdb_build_dir="/tmp/gdb-build"

gdb_version="gdb-8.3"

cd /tmp
wget https://ftp.gnu.org/gnu/gdb/$gdb_version.tar.xz
tar xf $gdb_version.tar.xz
mkdir $gdb_build_dir && cd $gdb_build_dir
/tmp/$gdb_version/configure --prefix=/usr --target=avr
make -C $gdb_build_dir
