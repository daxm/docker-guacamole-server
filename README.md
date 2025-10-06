# Docker Guacamole Server

A Docker Compose setup for Apache Guacamole 1.6.0 with MySQL backend and NGINX HTTPS frontend. Supports VNC/RDP/SSH/Telnet. Designed for internal networks with a DNS-resolvable hostname.

## Quick Start

### Clone & Prep:

1. `git clone https://github.com/daxm/docker-guacamole-server.git`
2. `cd docker-guacamole-server`
3. `cp .env.example .env`
4. `nano .env`  Set passwords and SERVER_NAME (e.g., guacamole.local)

### Setup and Start:

1. `./runme.sh`
2. Access: https://<SERVER_NAME>:${HTTPS_PORT:-8443}
3. Login with: guacadmin/guacadmin
4. Change password via **Settings > Preferences**.

## Services

- MySQL: Persistent DB for users/connections (auto-initialized in ./mysql-data).
- guacd: Protocol proxy daemon (writes recordings to ./recordings).
- guacamole: Web app (Tomcat-based; reads recordings for playback).
- nginx: Reverse proxy with HTTPS (self-signed certs in ./nginx-certs).
- script-runner: Runs Python scripts for bulk configuration (see Scripts section).

## Customization

### Ports

- Configurable via .env (defaults: HTTP_PORT=8080, HTTPS_PORT=8443).

### Internal DNS

- Set SERVER_NAME in .env (defaults to guacamole.local).

### Logging

- Configured per service in docker-compose.yml with LOG_MAX_SIZE (default 10MB) and LOG_MAX_FILE (default 3 rotations).

### Recordings and Typescripts

- Enabled via RECORDING_ENABLED=true in docker-compose.yml file.
- Stored in ./recordings/{HISTORY_UUID}/recording.
- Configured per-connection in UI: **Settings > Connections > <CONNECTION> > Screen Recording** section.
    - Set **Recording Path:** to **\${HISTORY_PATH}/${HISTORY_UUID}**.
    - Check boxes for **Include key events:** and **Automatically create recording path:** 
    - For SSH connections, in the Typescript section.
        - Set **Typescript path:** to **\${HISTORY_PATH}/${HISTORY_UUID}** and check box the **Automatically create typescript path:** checkbox.
- If configured correctly you can then replay a session via the **View** link in the **Settings > History** page.  If there is no **View** link then most likely recording isn't (or wasn't) set up for that connection.

## Scripts

- The `script-runner` folder contains utilities for bulk configuration (e.g., `create_guacamole_structure.py` for user groups, users, connection groups, and connections).
- The `scripts` folder is for user-created Python scripts.
- Dependencies are listed in `script-runner/requirements.txt` and installed in the `script-runner` container.
- Run the default script:
  ```bash
  docker-compose run --rm script-runner python create_guacamole_structure.py
  ```
- Run a custom script from the `scripts` folder:
  ```bash
  docker-compose run --rm script-runner python /scripts/your_script.py
  ```
- Before running, update `script-runner/create_guacamole_structure.py` with your `guacadmin` authToken (obtain via `curl -X POST -d 'username=guacadmin&password=<your_password>' https://guacamole.local:8443/api/tokens --insecure`) and connection details.

## Troubleshooting

- Logs: `docker-compose logs -f`
- Verify logging: `docker inspect guac-mysql | grep -A 4 LogConfig`.
- Debug DB: `docker exec -it guac-mysql mysql -u <MYSQL_USER> -p<MYSQL_PASSWORD> <MYSQL_DATABASE>`.
    - Check tables: `SHOW TABLES;`
    - Check history: `SELECT history_id, connection_id, start_date FROM guacamole_connection_history ORDER BY start_date DESC;`
- Test connections: Ensure target servers are reachable (e.g., SSH port 22 open).
- Copy/paste: Use HTTPS for clipboard. For RDP, verify rdpclip. For VNC, use modern servers (e.g., TigerVNC).
- Recordings: Check ./recordings (e.g., ./recordings/\<UUID>/recording).
- Rebuild: `docker-compose down -v && docker-compose up --build`

## Upgrading

1. Pin images in docker-compose.yml to latest tags.
2. `docker-compose pull`
3. `./runme.sh`

Built with ❤️ by daxm and Grok!