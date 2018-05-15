#!/usr/bin/env bash

echo "Building environment in prepartion for running the docker-compose command."
echo ""

echo "Make folder to hold MySQL database."
mkdir -p ./mysql/database
echo ""
echo "Make folder to hold NGINX certs."
mkdir -p ./nginx/certs
cd ./nginx/certs
echo ""
echo "Create cert for NGINX."
sudo openssl req -newkey rsa:2048 -nodes -keyout nginx.key -x509  -days 1024 -out nginx.crt
echo ""
echo "Don't forget to modify the env_file settings to meet your needs.  (AKA change the default password to something else.)"
echo ""
