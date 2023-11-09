echo "generating root cert..."

openssl req -new -x509 -utf8 -nodes -subj "/CN=localhost" -extensions v3_ca -days 3650 -keyout certs/root.key -out certs/root.crt

echo "generating intermediate cert..."

openssl req -new -utf8 -nodes -subj "/CN=localhost" -keyout certs/intermediate.key -out certs/intermediate.csr
chmod og-rwx certs/intermediate.key
openssl x509 -req -extensions v3_ca -in certs/intermediate.csr -days 1825 -CA certs/root.crt -CAkey certs/root.key -CAcreateserial -out certs/intermediate.crt

echo "generating server cert..."

openssl req -new -utf8 -nodes -subj "/CN=localhost" -keyout certs/server.key -out certs/server.csr
chmod og-rwx certs/server.key
openssl x509 -req -in certs/server.csr -days 365 -CA certs/intermediate.crt -CAkey certs/intermediate.key -CAcreateserial -out certs/server.crt

echo "generating client cert..."

openssl req -new -utf8 -nodes -subj "/CN=kong" -keyout certs/client.key -out certs/client.csr
chmod og-rwx certs/client.key
openssl x509 -req -in certs/client.csr -days 365 -CA certs/intermediate.crt -CAkey certs/intermediate.key -CAcreateserial -out certs/client.crt


echo "append chain certs"

cat certs/intermediate.crt > certs/chain.crt
cat certs/root.crt >> certs/chain.crt
cat certs/intermediate.crt >> certs/server.crt
cat certs/intermediate.crt >> certs/client.crt
