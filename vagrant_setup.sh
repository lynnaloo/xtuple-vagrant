#!/bin/sh

# fix for error message from Vagrant, but it may still show up
if `tty -s`; then
   mesg n
fi

# set xtuple source directory
XTUPLE_DIR=/home/vagrant/dev/xtuple/
MODULE=/home/vagrant/dev/xtuple/lib
LIB=cdir /home/vagrant/dev/xtuple/enyo-client/application/

# handy little function from install_script
cdir() {
	cd $1
	echo "Changing directory to $1"
}

# install git
sudo apt-get install git -y
echo "Git has been installed!"

# this is temporary fix for the problem where Windows
# cannot translate the symlinks in the repository
cdir $MODULE
rm module
ln -s ../node_modules/ module
git update-index --assume-unchanged module

cdir $LIB
rm lib
ln -s ../../lib lib
git update-index --assume-unchanged lib

# go to xtuple source directory
cdir $XTUPLE_DIR

echo "Installing development environment"
bash scripts/install_xtuple.sh

# this is another Windows symlink fix
npm install

echo "The xTuple install development script is done!"
