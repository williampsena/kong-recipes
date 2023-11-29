FROM kong:3.1.1-alpine as base

ARG PG_EXTERNAL_HOST
ARG PG_EXTERNAL_PORT
ARG NGINX_TEMPLATE=/usr/local/share/lua/5.1/kong/templates/nginx.lua

USER root

ENV PG_EXTERNAL_HOST=$PG_EXTERNAL_HOST
ENV PG_EXTERNAL_PORT=$PG_EXTERNAL_PORT

RUN mkdir -p /usr/local/kong/logs && chown -R kong:kong /usr/local/kong

RUN apk update && apk upgrade
RUN apk add nano bash ca-certificates curl

RUN mkdir /etc/kong/conf && chown -R kong:kong /etc/kong/conf

COPY --chown=kong:kong ./certs/* /usr/local/share/ca-certificates
COPY --chown=kong:kong ./kong/conf /etc/kong/conf

# prepare nginx config file
RUN sed -e "s/{PG_EXTERNAL_HOST}/${PG_EXTERNAL_HOST}/g" -e "s/{PG_EXTERNAL_PORT}/${PG_EXTERNAL_PORT}/g" /etc/kong/conf/postgres-proxy.template.conf > /etc/kong/conf/postgres-proxy.conf 

# overrides kong template to support stream for postgres proxy
RUN mv ${NGINX_TEMPLATE} ${NGINX_TEMPLATE}.default && \
    sed '$ d' ${NGINX_TEMPLATE}.default > ${NGINX_TEMPLATE} && \
    cat /etc/kong/conf/append_nginx_kong_template.conf >> ${NGINX_TEMPLATE} && \
    chown -R 1000:1000 ${NGINX_TEMPLATE} 

USER kong