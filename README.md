This is a project to build a series of Docker containers to support Guacamole, with a MySQL backend, that is frontended by NGINX using HTTPS.

Notes to prep the server/VM to run/use this Git repo:
# Install Docker
```bash
sudo apt remove docker*
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
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
mkdir -C ~/containers/guacamole_project/mysql/database
mkdir -C ~/containers/guacamole_project/nginx/certs
cd ~/containers/guacamole_project/nginx/certs
sudo openssl req -newkey rsa:2048 -nodes -keyout nginx.key -x509  -days 1024 -out nginx.crt
cd ~/containers/guacamole_project
git clone https://github.com/daxm/guacamole_project
```

# Update env_file to meet password requirements
```bash
sudo docker-compose build
sudo docker-compose up -d
```
