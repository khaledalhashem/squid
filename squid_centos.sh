#!/bin/bash
# <UDF name="squid_user" Label="Proxy Username" />
# <UDF name="squid_password" Label="Proxy Password" />
# Squid Proxy Server
# Author: admin@hostonnet.com
# Blog: https://blog.hostonnet.com
# Edits: Khaled AlHashem
# Site: https://naur.us

squid_user=
squid_password=

yum update
yum -y install squid httpd-tools

htpasswd -b -c /etc/squid/passwd $squid_user $squid_password

#/bin/rm -f /etc/squid/squid.conf
touch /etc/squid/blacklist.acl
#/usr/bin/wget --no-check-certificate -O /etc/squid/squid.conf  https://github.com/khaledalhashem/squid/raw/master/squid_centos.conf

iptables -I INPUT -p tcp --dport 3128 -j ACCEPT
#/sbin/iptables-save
/sbin/service iptables save

systemctl restart squid
systemctl enable squid
systemctl status squid
#update-rc.d squid defaults
