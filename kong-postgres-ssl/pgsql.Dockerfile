FROM postgres:14-alpine

USER postgres

COPY --chown=postgres:postgres ./certs/server.crt ./certs/server.key /var/lib/postgresql/