#!/bin/bash

curl -R -O http://www.lua.org/ftp/lua-5.4.3.tar.gz
tar zxf lua-5.4.3.tar.gz
mv lua-5.4.3 lua
cd lua
make linux
cd ..
gcc -std=c11 -Wall -Wpedantic -o demo demo.c -I./lua/src -L./lua/src -llua -lm -ldl
./demo

