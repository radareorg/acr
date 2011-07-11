#!/bin/sh
#
# autogen script to create configure
 
PATH=./src:${PATH}
./configure $@
chmod +x ./src/acr ./src/acr-sh ./src/acr-cat
acr -e -p
make clean
