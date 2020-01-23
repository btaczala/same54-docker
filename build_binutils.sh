#!/bin/sh

package="binutils"
version="2.33.1"
name="$package-$version"

source_dir="/tmp/"
build_dir="/tmp/$name-build"

cd $source_dir
wget https://ftp.gnu.org/gnu/$package/$name.tar.xz
tar xf $name.tar.xz
mkdir $build_dir && cd $build_dir
/tmp/$name/configure --prefix=/usr --target=avr
make -C $build_dir -j$(nproc)
make -C $build_dir -j$(nproc) install
cd /
rm $build_dir -rfv
rm $source_dir/$name -rfv

