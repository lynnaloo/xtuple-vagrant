#!/bin/sh

# fix for error message from Vagrant, but it may still show up
if `tty -s`; then
   mesg n
fi

# set xtuple source directory
XTUPLE_DIR=/home/vagrant/dev/xtuple/

# handy little function from install_script
cdir() {
  echo "Changing directory to $1"
  cd $1
}

# install git
sudo apt-get install git -y
echo "Git has been installed!"

# clone production code, get current tag
git clone --recursive https://github.com/xtuple/xtuple.git
# go to xtuple source directory
cdir $XTUPLE_DIR
git remote add XTUPLE git://github.com/xtuple/xtuple.git
git fetch XTUPLE
git checkout `git describe --abbrev=0`

# this is temporary fix for the problem where Windows
# cannot translate the symlinks in the repository

# the more permanent solution would loop through the links and edit:
#SYMLINKS = git ls-files -s | awk '/120000/{print $4}'
#for LINK in $SYMLINKS
#then
# update symlinks
#git update-index --assume-unchanged $symlink
#end

# go to xtuple source directory
cdir $XTUPLE_DIR
git reset --hard

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

cdir $XTUPLE_DIR
echo "Installing development environment"
bash scripts/install_xtuple.sh

echo "The xTuple install script is done!"
