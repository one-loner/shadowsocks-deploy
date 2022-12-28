#!/bin/bash
echo installing packets
apt-get install -y shadowsocks-libev shadowsocks-v2ray-plugin simple-obfs
ipaddr=$(curl ifconfig.me/ip)
echo Enter port for shadowsocks proxy:
read port
echo Enter password for shadowsocks proxy:
read password
sed s/ExternalIP/$ipaddr/ shadowsocks.config.sample>shadowsocks.config
sed -i s/Port/$port/ shadowsocks.config
sed -i s/Password/$password/ shadowsocks.config
sed s/ExternalIP/$ipaddr/ shadowsocks-client.config.sample>shadowsocks-client.config
sed -i s/Port/$port/ shadowsocks-client.config
sed -i s/Password/$password/ shadowsocks-client.config

cat shadowsocks.config>/etc/shadowsocks-libev/config.json
cat shadowsocks.service> /etc/systemd/system/shadowsocks.service
systemctl daemon-reload
systemctl start shadowsocks
systemctl enable shadowsocks
