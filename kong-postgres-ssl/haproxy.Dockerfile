FROM haproxy:2.8

USER root

RUN mkdir -p /var/lib/haproxy/certs /run/haproxy

COPY --chown=haproxy:haproxy ./proxy/haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY --chown=haproxy:haproxy ./certs/* /var/lib/haproxy/certs

RUN chown haproxy:haproxy /run/haproxy /var/lib/haproxy/certs

USER haproxy