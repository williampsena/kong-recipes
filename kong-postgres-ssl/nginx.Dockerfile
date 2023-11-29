FROM nginx:1.21.4

USER root

RUN apt update -y && apt upgrade -y

COPY --chown=nginx:nginx ./proxy/nginx.conf /etc/nginx/nginx.conf
COPY --chown=nginx:nginx ./certs/* /usr/local/share/ca-certificates

RUN chown -R nginx:nginx /etc/nginx /var/cache/nginx /run /usr/local/share/ca-certificates

USER nginx