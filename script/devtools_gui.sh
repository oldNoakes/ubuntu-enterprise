#!/bin/bash

if [[ ! "$DESKTOP" =~ ^(true|yes|on|1|TRUE|YES|ON])$ ]]; then
  exit
fi

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
apt-key add microsoft.gpg
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

echo "Installing Visual Studio Code"
apt-get update
apt-get -y install libxss1
apt-get -y install code

echo "Installing Firefox"
apt-get -y install firefox

echo "Installing gnome-terminal"
apt-get -y install gnome-terminal