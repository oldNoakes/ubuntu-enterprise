#!/bin/bash -eux

echo "Setting up requirements for adding a repository"
apt-get -y install software-properties-common python-software-properties

echo "Installing latest Git"
add-apt-repository ppa:git-core/ppa
apt-get update
apt-get -y install git

echo "Installing openJDK 8"
apt-get -y install openjdk-8-jdk-headless

echo "Finished installing CLI based development tools"