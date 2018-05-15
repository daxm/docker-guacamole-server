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

# Make development environment
```bash
mkdir -p ~/containers
cd ~/containers
git clone https://github.com/daxm/docker-guacamole-server
cd ./docker-guacamole-server
```

# Prep MySQL and NGINX environments
This file will create a directory for the mysql database and build a cert for nginx.
```bash
cd ~/containers/docker-guacamole-server
./runme.sh
```

# Update env_file to meet password requirements
```bash
cd ~/containers/docker-guacamole-server
nano ./env_file
```

# Use docker-compose to build/start containers
```bash
cd ~/containers/docker-guacamole-server
sudo docker-compose up --build --detach --remove-orphans
```
