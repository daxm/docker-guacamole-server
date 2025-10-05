Docker Guacamole Server (Modernized)
A Docker Compose setup for Apache Guacamole 1.6.0 with MySQL backend and NGINX HTTPS frontend. Supports VNC/RDP/SSH/Telnet. Designed for internal networks with a DNS-resolvable hostname.
Quick Start

Clone & Prep:
git clone https://github.com/daxm/docker-guacamole-server.git
cd docker-guacamole-server
git checkout dev
cp .env.example .env
nano .env  # Set passwords and SERVER_NAME (e.g., guacamole.local)


Setup and Start:
./runme.sh


Access: https://<SERVER_NAME>:${HTTPS_PORT:-8443} (login: guacadmin/guacadmin). Change password via Settings > Preferences.


Services

MySQL: Persistent DB for users/connections (auto-initialized in ./mysql-data).
guacd: Protocol proxy daemon (writes recordings to ./recordings).
guacamole: Web app (Tomcat-based; reads recordings for playback).
nginx: Reverse proxy with HTTPS (self-signed certs in ./nginx-certs).

Customization

Ports: Configurable via .env (defaults: HTTP_PORT=8080, HTTPS_PORT=8443).
Internal DNS: Set SERVER_NAME in .env (e.g., guacamole.local; defaults to localhost).
Logging: Configured per service in docker-compose.yml with LOG_MAX_SIZE (default 10MB) and LOG_MAX_FILE (default 3 rotations).
Recordings: Enabled via RECORDING_ENABLED=true. Stored in ./recordings/{HISTORY_UUID}/recording.guac. Configure per-connection in UI: Settings > Connections > Screen Recording > Enable + Path=${HISTORY_PATH}/${HISTORY_UUID} + Check "Automatically create recording path" + Set "Do not write to existing recordings" + Include key events. For SSH, enable Typescript recording with Path=${HISTORY_PATH}/${HISTORY_UUID} + Check "Automatically create typescript path" + Set "Do not write to existing typescripts". Supported tokens: ${GUAC_USERNAME}, ${GUAC_PASSWORD}, ${GUAC_CLIENT_ADDRESS}, ${GUAC_CLIENT_HOSTNAME}, ${GUAC_DATE} (YYYYMMDD), ${GUAC_TIME} (HHMMSS), ${HISTORY_PATH}, ${HISTORY_UUID} (session UUID).
Add connections/users via GUI (Settings > Connections).

Troubleshooting

Logs: docker-compose logs guac-guacamole (check /var/lib/docker/containers//.log).
Verify logging: docker inspect guac-mysql | grep -A 4 LogConfig.
Debug DB: docker exec -it guac-mysql mysql -u <MYSQL_USER> -p<MYSQL_PASSWORD> <MYSQL_DATABASE>.
Check tables: SHOW TABLES;
Check history: SELECT history_id, connection_id, start_date FROM guacamole_connection_history WHERE start_date > '2025-10-04' ORDER BY start_date DESC;


Test connections: Ensure target servers are reachable (e.g., SSH port 22 open).
Copy/paste: Use HTTPS for clipboard. For RDP, verify rdpclip. For VNC, use modern servers (e.g., TigerVNC).
Recordings: Check ./recordings (e.g., ./recordings/{session_uuid}/recording.guac). View in UI: Settings > Sessions > View link. Validate .guac: Check size (ls -lh recordings/...), play in UI, or convert to MP4 (docker run --rm -v $(pwd)/recordings:/recordings guacamole/guacd:1.6.0 guacenc -s 1024x768 -f mp4 /recordings/.../recording.mp4 /recordings/.../recording.guac). If no View link, verify permissions (sudo chown -R 1000:1000 recordings && chmod -R 2775 recordings), UI settings, and check if directory matches session UUID from logs (Connection ID is ...). Test container access: docker exec -it guac-guacamole sh -c "ls -l /var/lib/guacamole/recordings/{session_uuid}/*".
Rebuild: docker-compose down -v && docker-compose up --build.

Upgrading
Pin images in docker-compose.yml to latest tags. Pull & restart.
Built with ❤️ by daxm (2025 refresh).