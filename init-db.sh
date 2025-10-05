#!/bin/bash
set -e

# Generate schema
docker run --rm guacamole/guacamole:1.6.0 /opt/guacamole/bin/initdb.sh --mysql > initdb.sql

# Import to DB (using env vars from .env)
docker exec -i guac-mysql mysql -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} < initdb.sql

rm initdb.sql
echo "DB initialized! Restart services if needed: docker compose restart guacamole"
