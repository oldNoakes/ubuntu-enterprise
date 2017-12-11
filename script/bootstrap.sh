#!/bin/bash -eux

echo "Setting up localtime to Sydney"
ln -sf /usr/share/zoneinfo/Australia/Sydney /etc/localtime

echo "NOT IMPLEMENTED - TOOD: Inject DNS lookup zones into resolv.conf"
# see https://askubuntu.com/a/76430
