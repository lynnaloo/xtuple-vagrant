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

git reset --hard

# this is temporary fix for the problem where Windows
# cannot translate the symlinks in the repository

# the more permanent solution would loop through the links and edit:
#SYMLINKS = git ls-files -s | awk '/120000/{print $4}'
#for LINK in $SYMLINKS
#then
# update symlinks
#git update-index --assume-unchanged $symlink
#end

MODULE=/home/vagrant/dev/xtuple/lib
cdir $MODULE
rm module
ln -s ../node_modules/ module
git update-index --assume-unchanged module

LIB=cdir /home/vagrant/dev/xtuple/enyo-client/application/
cdir $LIB
rm lib
ln -s ../../lib lib
git update-index --assume-unchanged lib

# go to xtuple source directory
cdir $XTUPLE_DIR

echo "Installing development environment"
bash scripts/install_xtuple.sh

# this is another Windows symlink fix
#npm install

echo "The xTuple install development script is done!"
