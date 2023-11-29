# Generating certificates

> The commands should runs at **kong-recipes/kong-postgres-ssl* directory

To create trusted client, key, and server certificates, run the script **generate-certs.sh**.

```shell
bash generate-certs.sh
```

> Thank you Kong for great and detailed [documentation](https://docs.konghq.com/gateway/latest/production/networking/configure-postgres-tls/).

# Run containers

```shell
docker compose up -d postgres kong-migrations
# please wait migrations

docker compose up -d kong
```

# Logs

```shell
docker compose logs kong -f
```

# Testing

The Kong API Gateway is accessible through a variety of methods:

    - http://localhost:8001, with lua and Kong protected by SSL
    - http://localhost:8101, which uses a new container to serve as a proxy because it uses nginx as a proxy instead of Kong Lua to handle SSL.
    - http://localhost:8201, which uses the haproxy as a proxy with ssl;
    - http://localhost:8301, which uses the Kong Nginx Stream custom settings as proxy without utilizing Kong Lua to deal with SSL.

# Troubleshooting

If you encounter any problems during Kong Startup, please restart the container; migrations may not have been completed when Kong was launched.

```shell
docker compose restart kong 
```

> When your SSL connection is unsuccessful, you can use Nginx as a proxy, check port Kong at ports (8100 and 8101), which uses Postgres proxy at port 5431.
