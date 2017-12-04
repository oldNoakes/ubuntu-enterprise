#!/bin/bash
set -eux

echo "Removing old versions if installed"
apt-get -y remove docker docker-engine docker.io
apt-get -y update

echo "Ensure AUFS packages are installed for OverlayFS"
apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual

echo "Required packages for setting up Docker repo"
apt-get -y install apt-transport-https ca-certificates curl software-properties-common

echo "Install the docker repository"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
#add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu zesty stable" # Artful Aardvark still does not have a stable Docker-ce release

echo "Installing docker-ce"
apt-get -y update
apt-get -y install docker-ce

SSH_USER=${SSH_USERNAME:-ubuntu}
echo "Adding ${SSH_USER} to the docker role"
usermod --groups docker ${SSH_USER}

function inject_array_docker_daemon {
  local array=$1
  local key=$2
  if [ ! -z "${array}" ]
  then
    apt-get -y install jq
    local cleaned=$(echo -e ${array} | tr -d '[:space:]')
    local IFS=","
    for i in $cleaned
    do
      echo "Adding $i to ${key}"
      jq --arg KEY "${key}" --arg REGISTRY "${i}" '.[$KEY] += [$REGISTRY]' /etc/docker/daemon.json >> /etc/docker/daemon.tmp.json \
        && mv /etc/docker/daemon.tmp.json /etc/docker/daemon.json
    done
  fi
}

echo "{}" >> /etc/docker/daemon.json
inject_array_docker_daemon "${DOCKER_INSECURE_REGISTRIES}" "insecure-registries"
inject_array_docker_daemon "${DOCKER_DNS}" "dns"