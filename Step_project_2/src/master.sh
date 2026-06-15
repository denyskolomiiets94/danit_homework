#!/bin/bash

set -e

apt-get update -y

apt-get install -y \
  openjdk-21-jdk \
  curl \
  wget \
  net-tools

systemctl enable docker
systemctl start docker

wget https://get.jenkins.io/debian-stable/jenkins_2.528.1_all.deb

sudo apt install -y ./jenkins_2.528.1_all.deb

sudo apt -f install -y

sudo systemctl enable jenkins
sudo systemctl start jenkins