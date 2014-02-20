###  Install Vagrant ###

- Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
  - Do not open VirtualBox or create a virtual machine. This will be handled by Vagrant.
- Download and install [Vagrant](http://www.vagrantup.com/downloads.html)
  - Package managers like apt-get and gem install will install an older version of Vagrant so it is required to use the download page.

### Setup Vagrant ###

- [Optional] Edit the host machine's `hosts` file (private/etc/root) as root and add an entry for the virtual machine: `192.168.33.10 xtuple-vagrant`

Clone the `xtuple-vagrant` repository on the host computer:

    mkdir vagrant
    cd vagrant
    git clone https://github.com/xtuple/xtuple-vagrant.git
    cd xtuple-vagrant/demo

### Install VirtualBox Guest Additions Plugin

    vagrant plugin install vagrant-vbguest

### Connect to the Virtual Machine ###

Start the virtual machine:

    vagrant up
    
- Vagrant will automatically run a shell script to install git and the xTuple application

Connect to the virtual machine via ssh*:

    vagrant ssh
    
- Windows users will need to install [Git for Windows](http://msysgit.github.io/), or another ssh
  program in order to use this command
    
- The xTuple source code is synced to the folder `~/source`

Start the datasource:

    cd source/xtuple/node-datasource
    node main.js

Launch your local browser and navigate to the static IP Address `http://192.168.33.10:8888` or
the alias that you used in the hosts file `http://xtuple-vagrant:8888`

Default username and password to your local application are `admin`

### Additional Information ###

The virtual machine is shut-down with the command:

    vagrant halt

The virtual machine is started with the command:

    vagrant up

The virtual machine is destroyed with the command:

    vagrant destroy
