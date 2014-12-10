#!/bin/sh
#
# autogen script to create configure
 
PATH=./.bin/bin:${PATH}
rm -rf .bin
mkdir .bin
src/acr-sh > configure
chmod +x configure
./configure --prefix=/ $@
chmod +x ./src/acr ./src/acr-sh ./src/acr-cat ./src/acr-install
make install DESTDIR=$PWD/.bin
acr -e -p
make clean
rm -rf .bin
