#!/bin/sh
echo "server=${BIND_PORT_5300_UDP_ADDR}#${BIND_PORT_5300_UDP_PORT}" >> /etc/dnsmasq.conf
echo "no-resolv" >> /etc/dnsmasq.conf
#echo "resolv-file=/etc/dnsmasq.d/resolv.conf" >> /etc/dnsmasq.conf
# Use -d key for debugging
/usr/sbin/dnsmasq --keep-in-foreground
