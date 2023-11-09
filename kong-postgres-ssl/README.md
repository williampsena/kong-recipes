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

# Troubleshooting

If you encounter any problems during Kong Startup, please restart the container; migrations may not have been completed when Kong was launched.

```shell
docker compose restart kong 
```

> When your SSL connection is unsuccessful, you can use Nginx as a proxy, check port Kong at ports (8100 and 8101), which uses Postgres proxy at port 5431.
