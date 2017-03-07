#!/bin/bash
docker run -it \
 --name dnsmasq \
 -p 53:5353/udp \
 -v /etc/localtime:/etc/localtime:ro \
 --cap-add NET_ADMIN \
 --volumes-from dnsmasq-data \
 --link bind:bind \
 dmitriiageev/dnsmasq:latest
