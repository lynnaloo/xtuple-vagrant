#!/bin/sh

# fix for error message from Vagrant, but it may still show up
if `tty -s`; then
   mesg n
fi

# set xtuple source directory
XTUPLE_DIR=/home/vagrant/dev/xtuple/
# location of config file
FILE=$XTUPLE_DIR/node-datasource/config.js

# handy little function from install_script
cdir() {
	cd $1
	echo "Changing directory to $1"
}

# abort provisioning if development environment is already installed
if [ -f $FILE ];
then
   echo "Development environment has already been installed (config.js exists)"
else
   # install git
   sudo apt-get install git -y
   echo "Git has been installed!"

   # go to xtuple source directory
   cdir $XTUPLE_DIR
   echo "Now in the xtuple source directory"

   echo "Installing development environment"
   bash scripts/install_xtuple.sh
   echo "The xTuple install development script is done!"
fi
