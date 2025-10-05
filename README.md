Docker Guacamole Server (Modernized)

A Docker Compose setup for Apache Guacamole 1.6.0 with MySQL backend and NGINX HTTPS frontend. Supports VNC/RDP/SSH/Telnet. Designed for internal networks with a DNS-resolvable hostname.

Quick Start

1. Clone & Prep:
   - `git clone https://github.com/daxm/docker-guacamole-server.git`
   - `cd docker-guacamole-server`
   - `cp .env.example .env`
   - `nano .env`  # Update passwords/server_name/ports (e.g., SERVER_NAME=guacamole.local)

2. Generate Certs:
   - `chmod 755 *.sh`
   - `./generate-certs.sh` # Creates self-signed certs for internal DNS hostname

3. Start Services:
   - `docker compose up -d`

4. Init DB (once):
   - `./init-db.sh`

5. Connect:
    - Access: https://<SERVER_NAME>:${HTTPS_PORT:-443}
    - login: guacadmin/guacadmin
    - Change password via Settings > Preferences.

Services
- MySQL: Persistent DB for users/connections.
- guacd: Protocol proxy daemon.
- Guacamole: Web app (Tomcat-based).
- NGINX: Reverse proxy with HTTPS (self-signed certs).

Customization
- Ports: Configurable via .env (e.g., HTTP_PORT=8080 if 80 is taken).
- Internal DNS: Set SERVER_NAME in .env to your local hostname (e.g., guacamole.local; defaults to localhost).
- Logging: Global config via LOG_MAX_SIZE (default 10MB) and LOG_MAX_FILE (default 3 rotations) in .env.
- Add connections/users via GUI.

Troubleshooting
- Logs: docker compose logs guac-guacamole (view rotated files in /var/lib/docker/containers/*/*.log).
- Rebuild: docker compose down -v && docker compose up --build.
- Ports: Exposed via env vars; internal ports isolated.

Upgrading
Pin images in docker-compose.yml to latest tags. Pull & restart.

Built with ❤️ by daxm (2025 refresh).
