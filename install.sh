#!/bin/bash

set -o errexit   # exit on error

# Prerequisites
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install wget curl lua5.1 liblua5.1-0-dev zip unzip libreadline-dev libncurses5-dev libpcre3-dev openssl libssl-dev perl make build-essential -y

# OpenResty
cd ..
OVER=1.11.2.2
wget https://openresty.org/download/openresty-$OVER.tar.gz
tar xvf openresty-$OVER.tar.gz
cd openresty-$OVER
./configure
make
sudo make install
cd ..

# LuaRocks
LVER=2.4.1
wget https://keplerproject.github.io/luarocks/releases/luarocks-$LVER.tar.gz
tar xvf luarocks-$LVER.tar.gz
cd luarocks-$LVER
./configure
make build
sudo make install
# some rocks
sudo luarocks install lapis
sudo luarocks install moonscript

# cleanup
cd ..
rm -rf openresty*
rm -rf luarocks*

# okay now let's set it up
cd insecure-proxy
moonc .

# insecure-proxy as a service
echo "[Unit]
Description=insecure-proxy server
[Service]
Type=forking
WorkingDirectory=$(pwd)
ExecStart=$(which lapis) server development
ExecReload=$(which lapis) build development
ExecStop=$(which lapis) term
[Install]
WantedBy=multi-user.target" > insecure-proxy.service
sudo cp ./insecure-proxy.service /etc/systemd/system/insecure-proxy.service
sudo systemctl daemon-reload
sudo systemctl enable insecure-proxy.service
service insecure-proxy start
