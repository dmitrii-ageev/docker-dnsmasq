FROM alpine:latest
MAINTAINER Dmitrii Ageev <d.ageev@gmail.com>

RUN apk --no-cache add dnsmasq

VOLUME /etc/dnsmasq.d

ADD hosts /etc/dnsmasq.d/hosts
ADD dnsmasq.conf /etc/dnsmasq.conf
ADD start.sh /start.sh

EXPOSE 5353/udp
ENTRYPOINT ["/start.sh"]
