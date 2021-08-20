#!/bin/bash

# download a fresh version of lua and extract 
curl -R -O http://www.lua.org/ftp/lua-5.4.3.tar.gz
tar zxf lua-5.4.3.tar.gz

# rename the extracted directory
mv lua-5.4.3 lua

# call 'make' in a different directory ('lua') with param 'linux'
# same than: `cd lua; make linux; cd ..`
make -C lua linux

# call make in this directory and run a test
make && ./demo

