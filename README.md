Developing for xTuple using Vagrant
==============

## Instructions

- Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Install [Vagrant 1.3.4](http://downloads.vagrantup.com/tags/v1.3.4)
- Clone the `xtuple` and `xtuple-extensions` repositories to a directory on your host machine
- Clone this `xtuple-vagrant` repository in a separate directory
- Edit the `Vagrantfile` in the root of this repository and change the `sourceDir` variable to match the folder where you cloned the xTuple source code
- Edit the host machine's `hosts` file and add an entry for the virtual machine: `192.168.33.10 xtuple-vagrant`
- Run `vagrant up` from the root of this repository to load the new virtual machine
  - Vagrant will automatically run a shell script to install the xTuple development environment 
- Connect to the new virtual machine by running `vagrant ssh`
  - The xTuple source code is synced to the folder `~/dev`
