#!/bin/bash

apt-get update && apt-get -y install curl
curl https://raw.githubusercontent.com/fugroup/network-tools/master/debian-stretch-docker-init.sh | sh
