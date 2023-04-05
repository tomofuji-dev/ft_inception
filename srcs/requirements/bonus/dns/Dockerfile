FROM alpine:3.17

RUN apk update && \
    apk add --no-cache dnsmasq

COPY conf/dnsmasq.conf /etc/dnsmasq.conf

EXPOSE 53/tcp 53/udp

COPY tools/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["dnsmasq", "--no-daemon", "--log-facility=-"]