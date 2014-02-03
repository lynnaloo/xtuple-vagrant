#!/bin/sh

# fix for error message from Vagrant, but it may still show up
if `tty -s`; then
   mesg n
fi

# set xtuple source directory
XTUPLE_DIR=/home/vagrant/dev/xtuple/

# handy little function from install_script
cdir() {
	cd $1
	echo "Changing directory to $1"
}

# install git
sudo apt-get install git -y
echo "Git has been installed!"

# go to xtuple source directory
cdir $XTUPLE_DIR
echo "Now in the xtuple source directory"

echo "Installing submodules"
git submodule update --init --recursive

echo "Installing development environment"
bash scripts/install_xtuple.sh
echo "The xTuple install development script is done!"
