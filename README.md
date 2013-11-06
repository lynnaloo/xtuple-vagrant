## Creating a Vagrant Virtual Development Environment ##

[Vagrant](http://docs.vagrantup.com/v2/why-vagrant/index.html) is open-source software used to create lightweight and portable virtual development environments. Vagrant works like a "wrapper" for VirtualBox that can create, configure, and destroy virtual machines with the use of its own terminal commands. This facilitates the setup of environments that do not require any direct interaction with VirtualBox and allows developers to use software development tools in their native operating system.

###  Install Vagrant ###

- Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) 4.2
- Download and install [Vagrant](http://downloads.vagrantup.com/tags/v1.3.5) 1.3.5
  - Package managers like apt-get and gem install are installing an older version of Vagrant, so the download is recommended

This tutorial is currently geared towards Unix-based operating systems.
For Windows systems, [this](https://github.com/xtuple/xtuple/wiki/Step-by-step-setup-of-a-Virtual-Development-Environment-using-Vagrant) is currenty still the best tutorial to follow.

Create forks of the `xtuple`, `xtuple-extensions`, and `xtuple-vagrant` repositories on Github [HOW?](https://github.com/xtuple/xtuple/wiki/Setting-up-an-Ubuntu-Virtual-Machine#get-xtuple-code-base)

Clone the `xtuple` and `xtuple-extensions` repositories to a directory on your host machine:

    mkdir dev
    cd dev
    git clone git@github.com:{yourusername}/xtuple.git
    git clone git@github.com:{yourusername}/xtuple-extensions.git

Clone the `xtuple-vagrant` repository in a separate directory adjacent to your development folder:

    cd ..
    mkdir vagrant
    cd vagrant
    git clone git@github.com:{yourusername}/xtuple-vagrant.git

### Setup Vagrant ###

- Edit the `Vagrantfile` and change the `sourceDir` variable to match the location of the cloned xTuple source code: `sourceDir = "../../dev"`
  - This path should be relative to the location of the Vagrantfile

- [Optional] Edit the host machine's `hosts` file (private/etc/root) as root and add an entry for the virtual machine: `192.168.33.10 xtuple-vagrant`

### Connect to the Virtual Machine ###

Start the virtual machine:

    vagrant up
- Vagrant will automatically run a shell script to install git and the xTuple development environment

Connect to the virtual machine via ssh:

    vagrant ssh
- The xTuple source code is synced to the folder `~/dev`


Start the datasource:

    cd dev/xtuple/node-datasource
    sudo ./main.js

Launch your local browser and navigate to the static IP Address `http://192.168.33.10` or
the alias that you used in the hosts file `http://xtuple-vagrant`

Default username and password to your local application are `admin`

### Github SSH Key Pair ###
Create an SSH keypair so GitHub can authenticate your push requests:

    ssh-keygen # this isn't extremely secure but it'll do
    cat ~/.ssh/id_rsa.pub
    ssh-rsa AAA[...about 200 more characters]...M8n8/B xtuple@mobiledevvm

The cat command shows the public key that was just generated. Copy this text, starting with the ssh-rsa at the beginning and ending with the xtuple@mobiledevvm at the end (select and either right-click > Copy or Control-Shift-C in the Linux Terminal window).

In your web browser, navigate to your home page on GitHub. Click on Edit Your Profile. Select SSH Keys from the list on the left. Click Add SSH Key. Give this SSH key a title, such as "xTuple Mobile Dev VM", then paste the public key into the Key field. Finally click the Add key button. GitHub will verify your password just to make sure it's you at the keyboard.

### Additional Information ###

Edit `pg_hba.conf` to allow the host machine to access Postgres:

    vim cd/etc/postgresql/[postgres version]/main/pg_hba.conf
    
Add an entry for the IP address of the host machine:

    host    all     all     [host ip]/32   trust
    
The synced folder ```dev``` allows for files to be edited in either the virtual machine or on the host machine and the files will be synced both ways
