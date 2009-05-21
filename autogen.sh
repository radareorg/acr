#!/bin/sh
#
# autogen script to create configure
 
PATH=./src:${PATH}
./configure $@
chmod +x ./src/acr ./src/acr-sh ./src/acr-recover
acr -e -p
make clean
