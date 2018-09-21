#!/bin/bash

# Set up environment
echo 'LANGUAGE=en_US.UTF-8' >> /etc/environment
echo 'LANG=en_US.UTF-8' >> /etc/environment
echo 'LC_CTYPE=en_US.UTF-8' >> /etc/environment
echo 'LC_ALL=en_US.UTF-8' >> /etc/environment

# Change the welcome message
printf "Welcome.\n" > /etc/motd

# Install packages
apt-get update && apt-get -y install vim ufw git-core zsh curl apt-transport-https ca-certificates gnupg2 software-properties-common

# Install zsh
curl https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Set up SSH
sed -i -e 's/#Port 22/Port 33666/g' /etc/ssh/sshd_config
sed -i -e 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
kill `cat /var/run/sshd.pid`
service sshd start

# Install docker
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
apt-get update && apt-get install -y docker-ce

# Install docker compose
curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Fetch compose file
curl https://raw.githubusercontent.com/fugroup/network-tools/master/docker-compose.yml -s -o docker-compose.yml

# Start network
docker-compose -f docker-compose.yml up -d
