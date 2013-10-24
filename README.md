## Creating a Vagrant Virtual Development Environment ##

[Vagrant](http://docs.vagrantup.com/v2/why-vagrant/index.html) is open-source software used to create lightweight and portable virtual development environments. Vagrant works like a "wrapper" for VirtualBox that can create, configure, and destroy virtual machines with the use of its own terminal commands. This facilitates the setup of environments that do not require any direct interaction with VirtualBox and allows developers to use software development tools in their native operating system.

###  Install Vagrant ###

- Make sure that you first have [VirtualBox](https://www.virtualbox.org/wiki/Downloads) installed
- Download and install Vagrant 1.3.4 [here](http://downloads.vagrantup.com/tags/v1.3.4)
  - Package managers like apt-get and gem install are installing an older version, so the download is recommended

Clone the `xtuple` and `xtuple-extensions` repositories to a directory on your host machine:

    mkdir dev
    cd dev
    git clone git@github.com:{yourusername}/xtuple.git
    git clone git@github.com:{yourusername}/xtuple-extensions.git
    
Clone this `xtuple-vagrant` repository in a separate directory:

    mkdir vagrant
    cd vagrant
    git clone git@github.com:{yourusername}/xtuple-vagrant.git
    
### Setup Vagrant ###

- Edit the `Vagrantfile` and change the `sourceDir` variable to match the location of the cloned xTuple source code
- Edit the host machine's `hosts` file and add an entry for the virtual machine: `192.168.33.10 xtuple-vagrant`

### Connect to the Virtual Machine ###

Start the virtual machine:
    
    vagrant up
- Vagrant will automatically run a shell script to install git and the xTuple development environment 

Connect to the virtual machine via ssh:
    
    vagrant ssh
- The xTuple source code is synced to the folder `~/dev`

### Github SSH Key Pair ###
Create an SSH keypair so GitHub can authenticate your push requests:

    ssh-keygen # this isn't extremely secure but it'll do
    cat ~/.ssh/id_rsa.pub
    ssh-rsa AAA[...about 200 more characters]...M8n8/B xtuple@mobiledevvm

The cat command shows the public key that was just generated. Copy this text, starting with the ssh-rsa at the beginning and ending with the xtuple@mobiledevvm at the end (select and either right-click > Copy or Control-Shift-C in the Linux Terminal window).

In your web browser, navigate to your home page on GitHub. Click on Edit Your Profile. Select SSH Keys from the list on the left. Click Add SSH Key. Give this SSH key a title, such as "xTuple Mobile Dev VM", then paste the public key into the Key field. Finally click the Add key button. GitHub will verify your password just to make sure it's you at the keyboard.

### Additional Information ###

Edit `pg_hba.conf` file on the guest machine so that the host machine can access Postgres: 

    cd/etc/postgresql/[postgres version]/main

The synced folder ```dev``` allows for files to be edited in either the virtual machine or on the host machine and the files will be synced both ways
