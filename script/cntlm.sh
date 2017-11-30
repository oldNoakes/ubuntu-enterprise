#!/bin/bash
set -eux

apt-get -y install cntlm
systemctl stop cntlm

mv /tmp/cntlm/setup_proxy_password /usr/local/bin/setup_proxy_password
chmod a+x /usr/local/bin/setup_proxy_password 

## Extras
## Log to /var/log/cntlm.log
## Do we need to noproxy devtools?
## How to listen on IPV6 if needed