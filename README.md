chef-util
=========

Utilities for using chef to configure GENI-related development VMs.

Berkshelf
=========

See http://berkshelf.com for complete information on Berkshelf.

Berksfile
---------

Use berks to generate a gzipped tar file of all the cookbooks
configured in the `Berksfile`.

````
# In clone of this repository
berks package
````

This will produce a file like `cookbooks-1415345473.tar.gz` containing
all the cookbooks listed in `Berksfile` as well as all their
dependencies.
