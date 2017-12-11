#!/bin/bash

if [[ ! "$DESKTOP" =~ ^(true|yes|on|1|TRUE|YES|ON])$ ]]; then
  exit
fi

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
apt-key add microsoft.gpg
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

apt-get update
apt-get -y install code