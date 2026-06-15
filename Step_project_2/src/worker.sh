#!/bin/bash

apt-get update

apt-get install -y \
  openjdk-21-jdk \
  docker.io

systemctl enable docker
systemctl start docker

usermod -aG docker vagrant

id jenkins >/dev/null 2>&1 || useradd -m -s /bin/bash jenkins

usermod -aG docker jenkins

echo "jenkins ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/jenkins

chmod 440 /etc/sudoers.d/jenkins