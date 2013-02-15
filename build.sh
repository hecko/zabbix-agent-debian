#!/bin/bash

ZABBIX_VERSION='2.0.5'

sudo -i
apt-get install dh-make dpkg-dev debhelper devscripts fakeroot git
git clone https://github.com/hecko/zabbix-agent-debian.git
wget http://downloads.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/${ZABBIX_VERSION}/zabbix-${ZABBIX_VERSION}.tar.gz
tar xzfv zabbix-${ZABBIX_VERSION}.tar.gz
cd zabbix-${ZABBIX_VERSION}
dh_make -n -s -p zabbix-agent -e maco@blava.net
rm debian/*.ex debian/*.EX
rm debian/README debian/README.Debian
fakeroot debian/rules clean
cp ../meta/rules ./debian/
debian/rules build
fakeroot debian/rules binary
dpkg -c ../zabbix-agent_${ZABBIX_VERSION}_amd64.deb
