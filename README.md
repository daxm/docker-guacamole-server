This is a project to build a series of Docker containers to support Guacamole, with a MySQL backend, that is frontended by NGINX using HTTPS.

Notes to prep the server/VM to run/use this Git repo:
# Install Docker
```bash
./install_docker.sh
```

# Update env_file to meet password requirements
```bash
cd ~/containers/docker-guacamole-server
nano ./env_file
```

# Prep MySQL and NGINX environments and then build containers
This file will create a directory for the mysql database and build a cert for nginx.
```bash
cd ~/containers/docker-guacamole-server
./runme.sh
```

# Change Guacamole admin password
- Access your new guacamole GUI by browsing to the IP address of your server.
- Log in with **guacadmin**/**guacadmin**
- Navigate to **guacadmin > Settings > Users**
- Select **guacadmin**
- Update password field to be something new/unique and click **Save**.

