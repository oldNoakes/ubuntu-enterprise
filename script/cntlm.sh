#!/bin/bash -eux

# Install and then stop and disable CNTLM
apt-get -y install cntlm
systemctl stop cntlm
systemctl disable cntlm

# Move CNTLM logs to a separate file via rsyslog
mv /tmp/cntlm/syslog-cntlm.conf /etc/rsyslog.d/05-cntlm.conf
systemctl restart rsyslog

# Turn on verbose logging so we can see the details of requests in the log for debugging purposes
echo 'DAEMON_OPTS="-v"' >> /etc/default/cntlm

# Move the template file over to the right place
mv /tmp/cntlm/cntlm.conf /etc/cntlm.conf

# Create the local file to inject user provided credentials into the instance
mv /tmp/cntlm/setup_proxy_password /usr/local/bin/setup_proxy_password
chmod a+x /usr/local/bin/setup_proxy_password 

if [[ ! "${CNTLM_ENABLE}" =~ ^(true|yes|on|1|TRUE|YES|ON])$ ]]; then
  sed -i "s/REPLACE_ME_DOMAIN/${CNTLM_DOMAIN}/g" /etc/cntlm.conf
  sed -i "s/REPLACE_ME_PROXY/${CNTLM_PROXY}/g" /etc/cntlm.conf
  sed -i "s/REPLACE_ME_NOPROXY/${CNTLM_NO_PROXY}/g" /etc/cntlm.conf
  sed -i "s/REPLACE_ME_LISTENER/${CNTLM_PROXY_LISTEN}/g" /etc/cntlm.conf
  sed -i "s/REPLACE_ME_AUTH/${CNTLM_AUTH_TYPE}/g" /etc/cntlm.conf
fi

## Extras
## Do we need to noproxy devtools?
## How to listen on IPV6 if needed