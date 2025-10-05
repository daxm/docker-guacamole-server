#!/bin/bash
set -e

# Source .env file
if [ ! -f .env ]; then
  echo "Error: .env file not found. Please create one from .env.example."
  exit 1
fi
source .env

# Validate required environment variables
if [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_PASSWORD" ] || [ -z "$MYSQL_DATABASE" ]; then
  echo "Error: MYSQL_USER, MYSQL_PASSWORD, and MYSQL_DATABASE must be set in .env"
  exit 1
fi

# Generate schema
docker run --rm guacamole/guacamole:1.6.0 /opt/guacamole/bin/initdb.sh --mysql > initdb.sql

# Import to DB
docker exec -i guac-mysql mysql -u "${MYSQL_USER}" -p"${MYSQL_PASSWORD}" "${MYSQL_DATABASE}" < initdb.sql

rm initdb.sql
echo "DB initialized! Restart services if needed: docker compose restart guacamole"

