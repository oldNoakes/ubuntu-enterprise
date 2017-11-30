# Macquarie Bank - Ubuntu VM build via Packer
### Overview

This repository contains [Packer](https://packer.io/) templates for creating Ubuntu Vagrant boxes for use within Macquarie bank. The repository and the VMs it creates have no explicit support - they can be picked up and used on an as needed basis by any team and customized to those teams' requirements.

## Required dependencies (Windows)

In order to build a VM using this process, you will need the following:

    1. An account with elevated privileges on your Windows VM
    2. [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
    3. [CNTML](https://sourceforge.net/projects/cntlm/files/cntlm/)
    4. [Packer](https://www.packer.io/downloads.html)
    5. [PowerShell](https://github.com/PowerShell/PowerShell/releases)

TODO: Provide details on installation and CNTLM setup

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

### Acknowledgments

This repo is a heavily modified version of the https://github.com/boxcutter/ubuntu repository with a lot of the available customization ripped out.
