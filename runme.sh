#!/usr/bin/env bash

echo "Clean up prior installation files... if they even exist."
sudo rm -rf ./mysql/database ./nginx/certs
echo "Building environment in prepartion for running the docker-compose command."
echo "Make folder to hold MySQL database."
mkdir -p ./mysql/database
echo "Make folder to hold NGINX certs."
mkdir -p ./nginx/certs
cd ./nginx/certs
echo "Create cert for NGINX."
sudo openssl req -newkey rsa:2048 -nodes -keyout nginx.key -x509  -days 1024 -out nginx.crt
echo ""
echo "Start docker-compose build and launch containers if successful."
docker-compose up --build --detach --remove-orphans
