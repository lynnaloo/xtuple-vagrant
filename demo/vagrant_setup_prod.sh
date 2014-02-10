#!/bin/sh

# fix for error message from Vagrant, but it may still show up
if `tty -s`; then
   mesg n
fi

# set xtuple source directory
XTUPLE_DIR=/home/vagrant/source/xtuple/

# handy little function from install_script
cdir() {
  echo "Changing directory to $1"
  cd $1
}

# install git
sudo apt-get install git -y
echo "Git has been installed!"

# go to source shared folder
cd /home/vagrant/source/
# clone production code, get current tag
git clone --recursive https://github.com/xtuple/xtuple.git

# go to xtuple source directory
cdir $XTUPLE_DIR
git remote add XTUPLE git://github.com/xtuple/xtuple.git
git fetch XTUPLE
git checkout `git describe --abbrev=0`

cdir $XTUPLE_DIR
echo "Installing development environment"
bash scripts/install_xtuple.sh

echo "The xTuple install script is done!"
