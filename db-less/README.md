# It's time to put Kong API Gateway to the test.

## OK

```shell
curl --location --request GET 'http://localhost:8000/?passage=random&type=json' \
--header 'apikey: my-key' \
--header 'Content-Type: application/json' \
--header 'Accept: application/json'
```


## Access Denied

```shell
curl --location --request GET 'http://localhost:8000/?passage=random&type=json' \
--header 'apikey: key' \
--header 'Content-Type: application/json' \
--header 'Accept: application/json'
```

## Show logs from plugin file-log

```shell
docker-compose -f db-less/docker-compose.yml exec kong cat /tmp/api.log
```