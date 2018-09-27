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

# Install zsh config
git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git /root/.oh-my-zsh
cp /root/.oh-my-zsh/templates/zshrc.zsh-template /root/.zshrc
sed -i -e 's/# DISABLE_AUTO_UPDATE="true"/DISABLE_AUTO_UPDATE="true"/g' /root/.zshrc
sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/g' /root/.zshrc
chsh -s /usr/bin/zsh

# Set up SSH
sed -i -e 's/#Port 22/Port 33666/g' /etc/ssh/sshd_config
sed -i -e 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
service sshd restart

# Install docker
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
apt-get update && apt-get install -y docker-ce

# Install docker compose
curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Fetch compose file
curl -fsSL https://raw.githubusercontent.com/fugroup/network-tools/master/docker-compose.yml -o /root/docker-compose.yml

# Start network
docker-compose -f /root/docker-compose.yml up -d
