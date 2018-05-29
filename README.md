This is a project to build a series of Docker containers to support Guacamole, with a MySQL backend, that is frontended by NGINX using HTTPS.

Notes to prep the server/VM to run/use this Git repo:
# Install Docker
```bash
sudo apt remove docker*
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) nightly"
```
Note:  Ubuntu 18.04 doesn't have a "stable" repository yet.  Use the nightly until the stable is available.
* sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```bash
sudo apt update
sudo apt install docker-ce
```

# Install Python to install docker-compose
```bash
sudo apt install python3 python3-pip python3-setuptools
sudo -H pip3 install docker-compose
```

# Add user to docker group
```bash
sudo usermod -aG docker <your username here>
```
NOTE:  Don't forget.  You need to log out and log back in for the group assignment to take.

# Make development environment
```bash
mkdir -p ~/containers
cd ~/containers
git clone https://github.com/daxm/docker-guacamole-server
cd ./docker-guacamole-server
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
- Log in with guacadmin/guacadmin
- Navigate to guacadmin > Settings > Users
- Select guacadmin
- Update password field to be something new/unique and click Save.

