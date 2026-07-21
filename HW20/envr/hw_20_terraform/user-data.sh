#!/usr/bin/env bash
#!/bin/bash
set -e

apt-get update -y

# Docker
apt-get install -y docker.io

systemctl enable docker
systemctl start docker

docker pull nginx:latest

# Запускаємо nginx
docker run -d \
  --name nginx \
  --restart unless-stopped \
  -p 80:80 \
  nginx:latest