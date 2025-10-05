#!/bin/bash
set -e

# Load SERVER_NAME from .env
source .env

mkdir -p nginx-certs
cd nginx-certs

# Generate self-signed cert (valid 365 days; uses SERVER_NAME from .env)
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout server.key \
  -out server.crt \
  -subj "/C=US/ST=State/L=City/O=Org/CN=${SERVER_NAME:-localhost}"

echo "Certs generated in ./nginx-certs/ for ${SERVER_NAME:-localhost}."
