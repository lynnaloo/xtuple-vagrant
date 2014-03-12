#!/bin/sh

# fix for error message from Vagrant, but it may still show up
if `tty -s`; then
   mesg n
fi

# set xtuple source directory
XTUPLE_DIR=/home/vagrant/dev/xtuple/
PRIVATE_DIR=/home/vagrant/dev/private-extensions
BI_DIR=/home/vagrant/dev/bi

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
echo "Updating xtuple repository"
git reset --hard
git remote add XTUPLE https://github.com/xtuple/xtuple.git
git fetch XTUPLE
git merge XTUPLE/master

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
    echo "Update private dependencies"
    npm install

    if [ -d "$BI_DIR" ]; then
        # if bi exists, install extension
        cdir $XTUPLE_DIR
        echo "installing bi extension"
    fi
fi

cdir $XTUPLE_DIR
echo "Beginning install script"
bash scripts/install_xtuple.sh

echo "The xTuple install development script is done!"
