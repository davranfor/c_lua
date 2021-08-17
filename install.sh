#!/bin/bash

curl -R -O http://www.lua.org/ftp/lua-5.4.3.tar.gz
tar zxf lua-5.4.3.tar.gz
mv lua-5.4.3 lua
cd lua
make linux
cd ..
make
./demo

