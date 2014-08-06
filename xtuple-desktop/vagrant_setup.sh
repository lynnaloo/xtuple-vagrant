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
echo "Installing Git"
sudo apt-get install git -y

# this is temporary fix for the problem where Windows
# cannot translate the symlinks in the repository
echo "Creating symlink to lib folder"
cd /home/vagrant/dev/xtuple/lib/
rm module
ln -s ../node_modules/ module
git update-index --assume-unchanged module

echo "Creating symlink to application folder"
cd /home/vagrant/dev/xtuple/enyo-client/application/
rm lib
ln -s ../../lib/ lib
git update-index --assume-unchanged lib

cdir $XTUPLE_DIR
echo "Beginning install script"
bash scripts/install_xtuple.sh

echo "Adding Vagrant PostgreSQL Access Rule"
echo "host all all  0.0.0.0/0 trust" | sudo tee -a /etc/postgresql/9.1/main/pg_hba.conf

echo "Restarting Postgres Database"
sudo service postgresql restart

##begin qtdev wizardry
cd /home/vagrant/dev
sudo apt-get install -q -y libfontconfig1-dev libkrb5-dev libfreetype6-dev libx11-dev libxcursor-dev libxext-dev libxfixes-dev libxft-dev libxi-dev libxrandr-dev libxrender-dev ubuntu-desktop
wget http://download.qt-project.org/official_releases/qt/4.8/4.8.6/qt-everywhere-opensource-src-4.8.6.tar.gz
tar xvf qt-everywhere-opensource-src-4.8.6.tar.gz
cd qt-everywhere-opensource-src-4.8.6/
echo "Configuring Qt"
./configure -qt-zlib -qt-libtiff -qt-libpng -qt-libmng -qt-libjpeg -plugin-sql-psql -plugin-sql-odbc -plugin-sql-sqlite -I /usr/local/pgsql/include -L /usr/local/pgsql/lib -lkrb5 -webkit -confirm-license -fontconfig -opensource -continue
echo "Installing Qt 4.8.6--GO GET SOME COFFEE IT'S GOING TO BE A WHILE"
make -j4
sudo make -j1 install
echo "Compiling OPENRPT dependency"
cd /home/vagrant/dev/qt-client/openrpt
/usr/local/Trolltech/Qt-4.8.6/bin/qmake
make -j4
echo "Compiling CSVIMP dependency"
cd ../csvimp
/usr/local/Trolltech/Qt-4.8.6/bin/qmake
make -j4
echo "Qt development environment finished!"
echo "To get started cd /home/vagrant/dev/qt-client qmake then make to build xTuple desktop!"
##end qtdev wizardry

echo "The xTuple Server install script is done!"
