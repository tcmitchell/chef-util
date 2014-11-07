#!/bin/sh
#----------------------------------------------------------------------
# Shell script to:
#  1. Install chef
#  2. Install the gpo-sw chef repo
#  3. Execute chef in local mode to install gcf dependencies
#
# This script was inspired by and derived from the mytestbed
# slice-service chef project on github. Thanks to them for blazing the
# trail.
#
# TODO: [FIND THE GITHUB URL]
#
# TODO: Take an argument to be appended to the solo json file name.
#       For example, an argument of "gcf" would use solo-gcf.json.
#       No argument means use solo.json. Not sure what should go
#       in that file. Perhaps nothing?
#----------------------------------------------------------------------


# curl -O http://www.gpolab.bbn.com/experiment-support/gposw/aa/install.sh
# curl -O http://www.gpolab.bbn.com/experiment-support/gposw/aa/chef-repo-2.tar.gz

INSTALL_CHEF_URL=https://www.opscode.com/chef/install.sh

if ! type "chef-solo" > /dev/null; then
  if type "curl" > /dev/null; then
    curl -o getchef.sh "${INSTALL_CHEF_URL}" && bash getchef.sh && rm getchef.sh
  elif type "wget" > /dev/null; then
    wget "${INSTALL_CHEF_URL}" -O getchef.sh && bash getchef.sh && rm getchef.sh
  else
    echo "No curl or wget -- help!"
    exit 1
  fi
fi

REPO_TGZ=http://www.gpolab.bbn.com/experiment-support/gposw/aa/chef-repo.tar.gz

#wget https://github.com/jackhong/chef-repo/archive/master.tar.gz --no-check-certificate -O chef-repo.tar.gz
if type "curl" > /dev/null; then
  curl -O "${REPO_TGZ}"
elif type "wget" > /dev/null; then
  wget "${REPO_TGZ}"
else
  echo "No curl or wget -- help!"
  exit 1
fi

rm -rf chef-repo
tar xzf chef-repo.tar.gz
rm chef-repo.tar.gz
#mv chef-repo-master chef-repo

cd chef-repo && chef-client -z -c solo/solo.rb -j solo/solo.json && cd ..
rm -rf chef-repo
