# Dotfiles
This is a set of configuration files and scripts I use to customize my Linux and OS X systems.

# How to use
You should perhaps use this repository as a reference, rather than applying 
all changes to your system directly, but here's what I do:

    git clone https://github.com/ganczarek/dotfiles ~/.dotfiles
    cd ~/.dotfiles
    sh setup.sh

`setup.sh` script should setup your machine and link all configuration files to 
appropriate places. If a configuration file already exists, it will back it up 
first and then create new symbolic link to `~/.dotfiles`. You can execute
`setup.sh` multiple times. 

## Vagrant
You can test shell customization on Arch Linux with Vagrant. Execute:

    cd ~/.dotfiles/vagrant
    sh run.sh

This script will create a new VM, execute `setup.sh` script and ssh
to that machine. Once you're done, destroy VM with

    vagrant destroy
