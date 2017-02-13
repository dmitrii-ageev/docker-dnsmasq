FROM alpine:latest
MAINTAINER Dmitrii Ageev <d.ageev@gmail.com>

RUN apk --no-cache add dnsmasq

VOLUME /etc/dnsmasq.d

ADD hosts /etc/dnsmasq.d/hosts
ADD resolv.conf /etc/dnsmasq.d/resolv.conf
ADD dnsmasq.conf /etc/dnsmasq.conf

EXPOSE 5353/udp
ENTRYPOINT ["/usr/sbin/dnsmasq","--keep-in-foreground" ]
