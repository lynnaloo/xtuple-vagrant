## Creating a Vagrant Virtual Development Environment ##

[Vagrant](http://docs.vagrantup.com/v2/why-vagrant/index.html) is open-source software used to create lightweight and portable virtual development environments. Vagrant works like a "wrapper" for VirtualBox that can create, configure, and destroy virtual machines with the use of its own terminal commands. Vagrant facilitates the setup of environments without any direct interaction with VirtualBox and allows developers to use preferred editors and browsers in their native operating system. [This blog](http://mitchellh.com/the-tao-of-vagrant) describes a typical workflow using Vagrant in a development environment.

Note: This document is for setting up a virtual environment on a Unix host. If you are using a Windows host,
please use [these instructions](../../wiki/Creating-a-Vagrant-Virtual-Environment-on-a-Windows-Host).

###  Install Vagrant ###

- Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
  - Do not open VirtualBox or create a virtual machine. This will be handled by Vagrant.
- Download and install [Vagrant](http://www.vagrantup.com/downloads.html)
  - Package managers like apt-get and gem install will install an older version of Vagrant so it is required to use the download page.

[Fork](http://github.com/xtuple/xtuple/fork) the `xtuple`, [fork](http://github.com/xtuple/xtuple-extensions/fork)  `xtuple-extensions`, and [fork](http://github.com/xtuple/xtuple-vagrant/fork)  `xtuple-vagrant` repositories on Github.

Clone your forks of the `xtuple` and `xtuple-extensions` repositories to a directory on your host machine and get the latest code from the xTuple repository:

    mkdir dev
    cd dev
    git clone --recursive https://github.com/<username>/xtuple.git
    git clone --recursive https://github.com/<username>/xtuple-extensions.git
    
Clone your fork of the `xtuple-vagrant` repository in a separate directory adjacent to your development folder:

    cd ..
    mkdir vagrant
    cd vagrant
    git clone https://github.com/<username>/xtuple-vagrant.git
    cd xtuple-vagrant
    
Important: If you have previously forked these repositories, please ensure that you [update your fork](../../../xtuple/wiki/Basic-Git-Usage#wiki-merging) and [update your dependencies](../../../xtuple/wiki/Upgrading#wiki-update-stack-dependencies).    

### Setup Vagrant ###

- In the `Vagrantfile`, ensure that the `sourceDir` variable to matches the location of the cloned xTuple source code: `sourceDir = "../../dev"`
  - This path should be relative to the location of the Vagrantfile

- [Optional] Edit the host machine's `hosts` file (private/etc/root) as root and add an entry for the virtual machine: `192.168.33.10 xtuple-vagrant`

### Install VirtualBox Guest Additions Plugin

    vagrant plugin install vagrant-vbguest

### Connect to the Virtual Machine ###

Start the virtual machine:

    vagrant up
    
- Vagrant will automatically run a shell script to install git and the xTuple development environment

Connect to the virtual machine via ssh:

    vagrant ssh
    
- The xTuple source code is synced to the folder `~/dev`

Start the datasource:

    cd dev/xtuple/node-datasource
    node main.js

Launch your local browser and navigate to the static IP Address `http://192.168.33.10:8888` or
the alias that you used in the hosts file `http://xtuple-vagrant:8888`

Default username and password to your local application are `admin`

### Additional Information ###

Accessing the Vagrant Postgres Database from the Host:

[Allow host access](../../wiki/Vagrant-Tips-and-Tricks#wiki-accessing-the-vagrant-postgres-database-from-the-host)

Shutting down, restarting, and destroying your VM:

[Basic commands](../../wiki/Vagrant-Tips-and-Tricks#wiki-vagrant-commands)
