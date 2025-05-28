#!/bin/bash
DOMAIN="app.4xexch.com"
EMAIL="sourbhupadhayay@gmail.com"

apt update
apt install -y certbot

certbot certonly --webroot \
  -w /usr/share/nginx/html \
  -d $DOMAIN \
  --agree-tos \
  --email $EMAIL \
  --non-interactive
