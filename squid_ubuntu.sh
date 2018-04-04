#!/bin/bash
# <UDF name="squid_user" Label="Proxy Username" />
# <UDF name="squid_password" Label="Proxy Password" />
# Squid Proxy Server
# Author: admin@hostonnet.com
# Blog: https://blog.hostonnet.com
# Edits: Khaled AlHashem
# Site: https://knaved.com

squid_user=
squid_password=

/usr/bin/apt update
/usr/bin/apt -y install apache2-utils squid3

/usr/bin/htpasswd -b -c /etc/squid/passwd $squid_user $squid_password

/bin/rm -f /etc/squid/squid.conf
/usr/bin/touch /etc/squid/blacklist.acl
/usr/bin/wget --no-check-certificate -O /etc/squid/squid.conf https://github.com/khaledalhashem/squid/raw/master/squid_ubuntu.conf

/sbin/iptables -I INPUT -p tcp --dport 3128 -j ACCEPT
/sbin/iptables-save

service squid restart
update-rc.d squid defaults
