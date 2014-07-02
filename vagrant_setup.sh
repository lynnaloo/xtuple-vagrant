#!/bin/sh

# fix for error message from Vagrant, but it may still show up
if `tty -s`; then
   mesg n
fi

# set xtuple source directory
XTUPLE_DIR=/home/vagrant/dev/xtuple/

echo "Installing the xTuple Server"

cd $XTUPLE_DIR

#before_install:
rm -rf ~/.nvm
wget git.io/hikK5g -qO- | sudo bash
n latest
npm install xtuple-server -g
n stable

#install:
npm install
sudo xtuple-server install-dev --xt-demo --pg-worldlogin

#before_script:
npm run test-build
npm start & sleep 10

#script:
npm test
npm run test-datasource
npm run jshint

echo "The xTuple Server install is now complete."
