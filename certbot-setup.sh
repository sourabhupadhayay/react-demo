#!/bin/bash
DOMAIN="app.4xexch.com"
EMAIL="sourbhupadhayay@gmail.com"

# Stop anything using port 80
fuser -k 80/tcp || true

docker run --rm -p 80:80 \
  -v /etc/letsencrypt:/etc/letsencrypt \
  -v /var/lib/letsencrypt:/var/lib/letsencrypt \
  certbot/certbot certonly --standalone \
  -d "$DOMAIN" --agree-tos --email "$EMAIL" --non-interactive
