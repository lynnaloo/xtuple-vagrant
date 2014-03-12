#!/bin/sh

# fix for error message from Vagrant, but it may still show up
if `tty -s`; then
   mesg n
fi

# set xtuple source directory
XTUPLE_DIR=/home/vagrant/dev/xtuple/
PRIVATE_DIR=/home/vagrant/dev/private-extensions

# handy little function from install_script
cdir() {
	echo "Changing directory to $1"
	cd $1
}

# install git
sudo apt-get install git -y
echo "Git has been installed!"

# go to xtuple source directory
cdir $XTUPLE_DIR
# update the code from upstream
git reset --hard
git remote add XTUPLE https://github.com/xtuple/xtuple.git

# this is temporary fix for the problem where Windows
# cannot translate the symlinks in the repository
echo "Changing directory to lib"
cd /home/vagrant/dev/xtuple/lib/
rm module
ln -s ../node_modules/ module
git update-index --assume-unchanged module

echo "Changing directory to application"
cd /home/vagrant/dev/xtuple/enyo-client/application/
rm lib
ln -s ../../lib/ lib
git update-index --assume-unchanged lib

if [ -d "$PRIVATE_DIR" ]; then
    # if private exists, npm install
    cdir $PRIVATE_DIR
    npm install
fi

cdir $XTUPLE_DIR
echo "Installing development environment"
bash scripts/install_xtuple.sh

# if private-extensions exists, 
echo "The xTuple install development script is done!"
