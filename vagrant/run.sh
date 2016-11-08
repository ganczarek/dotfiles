#!/usr/bin/env bash

command_exists() {
  command -v "$1" > /dev/null 2>&1
}

# Assure Vagrant is installed
if ! command_exists vagrant ; then
	if command_exists yaourt ; then
		echo "Installing vagrant with yaourt"
		yaourt -S vagrant
	else
		echo "Please install vagrant."
		exit -1
	fi
fi

vagrant up
vagrant ssh