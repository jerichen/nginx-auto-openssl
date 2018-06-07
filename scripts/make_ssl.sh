#!/bin/bash

# Config for SSL.
SSL_DIR="/etc/nginx/ssl"
OPENSSL_DIR="/etc/openssl-ssl"

echo "--- Making Gitlab SSL Directory ---"
mkdir -p "$OPENSSL_DIR"
chmod 777 "$OPENSSL_DIR"

# we want to keep dhparam.pem in volume, to generate just one time
if [ ! -f "/etc/openssl-ssl/nginx.crt" ]; then
  cp ${SSL_DIR}/nginx.crt /etc/openssl-ssl/nginx.crt
fi

if [ ! -f "/etc/openssl-ssl/nginx.key" ]; then
  cp ${SSL_DIR}/nginx.key /etc/openssl-ssl/nginx.key
fi
