#!/bin/bash
set -e

# Check and create directories with correct ownership and permissions
for dir in mysql-data nginx-certs recordings; do
  if [ ! -d "$dir" ]; then
    echo "Creating $dir..."
    mkdir -p "$dir"
  else
    echo "$dir already exists, skipping creation."
  fi
done

echo "Setting permissions for directories..."
sudo chown -R 1000:1000 mysql-data recordings
sudo chmod -R 770 mysql-data
sudo chown -R root:root nginx-certs
sudo chmod -R 755 nginx-certs
sudo chown -R 1000:1000 recordings
sudo chmod -R 2775 recordings

echo "Directories and permissions configured."

# Run docker-compose up -d
echo "Starting containers..."
docker-compose up -d

# Run init-db.sh if it exists
if [ -f "init-db.sh" ]; then
  echo "Initializing database..."
  chmod +x init-db.sh
  ./init-db.sh
else
  echo "Warning: init-db.sh not found, database initialization skipped."
fi

echo "Setup complete. Check logs with 'docker-compose logs -f'."