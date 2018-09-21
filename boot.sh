#!/bin/bash

apt-get update && apt-get -y install curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/fugroup/network-tools/master/debian-stretch-docker-init.sh)"
