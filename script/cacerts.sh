#!/bin/bash
set -eux

echo "Injecting Enterprise Certificates into default CA bundle"
apt-get -y install ca-certificates openssl

# Preferrably we should download the cert bundle from a known location - for now we will use a file copied over
for i in $(ls /tmp/certificates/*.crt)
do
  echo "Moving $i into ca-certificates bundle update location"
  mv $i /usr/local/share/ca-certificates
done

update-ca-certificates --fresh