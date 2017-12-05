#!/bin/bash
set -eux

apt-get -y install cntlm
systemctl stop cntlm

# Move CNTLM logs to a separate file via rsyslog
mv /tmp/cntlm/syslog-cntlm.conf /etc/rsyslog.d/05-cntlm.conf
systemctl restart rsyslog

# Turn on verbose logging so we can see the details of requests in the log for debugging purposes
echo 'DAEMON_OPTS="-v"' >> /etc/default/cntlm

mv /tmp/cntlm/setup_proxy_password /usr/local/bin/setup_proxy_password
chmod a+x /usr/local/bin/setup_proxy_password 

## Extras
## Do we need to noproxy devtools?
## How to listen on IPV6 if needed