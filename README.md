# Enterprise Ubuntu VM build via Packer
## Overview

This repository contains [Packer](https://packer.io/) templates for creating Ubuntu Vagrant/Virtualbox boxes for use within Enterprise environment. 

The packer build creates an Ubuntu Server/Desktop that comes built in with:

1. An updated CA certificate authority based on the certificates provided in the ```files/certificates``` directory
2. CNTML installed with an automated configuration setup to inject username/password into the CNTLM configuration and inject the correct ENV variables into the setup
3. Docker installed and verified

## Required dependencies

In order to build a VM using this process, you will need the following install on your computer:

    1. An account with elevated privileges to install and run these applications
    2. [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
    3. [CNTML](https://sourceforge.net/projects/cntlm/files/cntlm/)
    4. [Packer](https://www.packer.io/downloads.html)
    5. [PowerShell](https://github.com/PowerShell/PowerShell/releases)

## Building the Vagrant boxes with Packer

The builds in this setup are optimized for Virtualbox - if you want to use one of the other available Packer builders, that is something you will need to sort out.

To build the VM (in powershell terminal):

```
# Setup the CNTLM proxy env for the packer build to use
$env:http_proxy="127.0.0.1:3128"
$env:https_proxy="127.0.0.1:3128"

# Run the packer process
packer build -only=virtualbox-iso -var-file=ubuntu1710.json ubuntu.json
```

The ```-var-file``` is a file that contains variables specific to the build of ubuntu 17.10 while the ```ubuntu.json``` file is a more generic build that can support multiple versions of ubuntu.

## Publishing the VM

The VM that this build creates should be shared via uploading to a publicly available repository within your enterprise.  This then provides all users within your company a common place to pull down the latest build of this environment for their own usage.

### Proxy Settings

The templates respect the following network proxy environment variables
and forward them on to the virtual machine environment during the box creation
process, should you be using a proxy:

* http_proxy
* https_proxy
* ftp_proxy
* rsync_proxy
* no_proxy

### Tests

Automated tests are written in [goss](https://github.com/aelsabbahy/goss) - they are run in the custom script ```goss.sh``` and the tests are defined in the __files/goss__ base directory.

## Acknowledgments

This repo is a heavily modified version of the https://github.com/boxcutter/ubuntu repository with a lot of the available customization ripped out.
