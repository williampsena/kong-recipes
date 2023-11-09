FROM kong:3.1.1-alpine as base

USER root

RUN mkdir -p /usr/local/kong/logs && chown -R kong:kong /usr/local/kong

RUN apk update && apk upgrade
RUN apk add nano bash ca-certificates curl

COPY ./certs/* /usr/local/share/ca-certificates

USER kong