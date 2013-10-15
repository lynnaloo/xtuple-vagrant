#!/bin/sh

if `tty -s`; then
   mesg n
fi

# set xtuple source directory
XTUPLE_DIR="dev/xtuple"
# location of config file
FILE="~/dev/xtuple/node-datasource/config.js"

# abort provisioning if development environment is already installed
if [ -f $FILE ];
then
   echo "Development environment has been installed"
else
   # install git
   sudo apt-get install git -y

   # go to xtuple source directory
   cd $XTUPLE_DIR
   echo "Now in the xtuple source directory"

   echo "Installing development environment"
   sudo sh ./scripts/install_xtuple.sh
   echo "The xTuple install development script is done!" 
fi
