#!/bin/bash
set -eux

echo "Installing goss"
apt-get -y install jq
download_url=$(curl -s https://api.github.com/repos/aelsabbahy/goss/releases/latest | jq -r ".assets[] | select(.name | test(\"goss-linux-amd64\")) | .browser_download_url")
wget -nv $download_url -O /usr/local/bin/goss
chmod a+x /usr/local/bin/goss

echo "Running goss test"
/usr/local/bin/goss -g /tmp/goss/goss.yml validate --format documentation || true

