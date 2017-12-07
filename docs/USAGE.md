# Using the Ubuntu Enterprise box

## VirtualBox

### Import and Configure

In order to use the VM with Virtualbox, you need to follow these steps:

1. Import the OVF file (_import appliance_) into Virtualbox
2. Modify the following resources available to the VM based on your use case (more resources will support more complex development processes):
  1. RAM
  2. CPU
3. Once the VM is imported into Virtualbox, you will want to configure the following:
  1. If you are using the __Desktop__ instance, update the Video Memory available to the machine
    1. Click on VM then __Settings -> Display -> Screen__ and update the Video Memory allocation
  2. Setup _port forwarding_ on the VM - this allows ports that you are using on the VM to be available to your host system.  Click on the VM then __Settings -> Network -> Advanced -> Port Forwarding__ and then provide the required details.
    1. To allow for SSH access to the box, add the following values:
      1. Host IP: 127.0.0.1
      2. Host Port: 2222
      3. Guest IP: 10.0.2.15
      4. Guest Port: 22
4. Start the VM and wait until a login box (either CLI or Desktop based) appears

### Using

Once the instance is up and running, the first thing you will need to do is configure CNTLM. In order to do so, run the following command from the command line (CLI) and provide the required information: ```/usr/local/bin/setup_proxy_password```

This will do the following:

1. Complete the creation of the ```/etc/cntlm.conf``` file with the required username and password (encrypted) to make it work
2. Enable and startup CNTML
3. Inject the following environment variables into the box:
  1. http_proxy / HTTP_PROXY
  2. https_proxy / HTTPS_PROXY
  3. ftp_proxy / FTP_PROXY