#!/bin/bash

# download a fresh version of lua and extract 
curl -R -O http://www.lua.org/ftp/lua-5.4.3.tar.gz
tar zxf lua-5.4.3.tar.gz

# call 'make' in a different directory ('lua') with param 'linux'
# same than: `cd lua; make linux; sudo make install; cd ..`
make -C lua-5.4.3 linux
sudo make -C lua-5.4.3 install

# call make in this directory and run a test
make && ./demo

