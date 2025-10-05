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

# Wait for MySQL to be ready
for i in {1..15}; do
  if docker exec guac-mysql mysqladmin ping -h localhost -u root -p${MYSQL_ROOT_PASSWORD} --connect_timeout=10; then
    echo "MySQL is ready"
    break
  fi
  echo "Waiting for MySQL (attempt $i)..."
  sleep 10
done
if [ $i -eq 15 ]; then
  echo "Error: MySQL did not start in time"
  exit 1
fi

# Generate and import schema
if ! docker exec guac-mysql mysql -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} -e 'SELECT 1 FROM guacamole_entity LIMIT 1'; then
  docker run --rm guacamole/guacamole:1.6.0 /opt/guacamole/bin/initdb.sh --mysql > initdb.sql
  docker exec -i guac-mysql mysql -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} < initdb.sql
  rm initdb.sql
  echo "Database initialized"
else
  echo "Database already initialized"
fi