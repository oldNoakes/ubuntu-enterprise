
# Info

The mozilla-root certificate in this directory should be removed and a certificate bundle and/or set of certificates in CRT format (PEM but renamed) should be added in its stead.

Alternatively, if you look at the file under ```script/cacerts.sh```, you could modify the code to automatically download a generated CRT bundle from a known location within your enterprise.  The benefit of this secondary method is that it allows the creation of that bundle to be externalized and therefore updates to this bundle will simply flow through to the Packer build process when it is automatically updated. 