SetFileProperty / mode 555

CopyFile /etc/default/grub

# Load acpi_call module (e.g. for set_charge_limit.sh)
AddPackage acpi_call # A linux kernel module that enables calls to ACPI methods through /proc/acpi/call
CopyFile /etc/modules-load.d/acpi_call.conf

AddPackage nix # A purely functional package manager
CopyFile /etc/nix/nix.conf
CreateLink /etc/systemd/system/multi-user.target.wants/nix-daemon.service /usr/lib/systemd/system/nix-daemon.service

CopyFile /etc/security/faillock.conf
CopyFile /etc/sysctl.d/99-reisub.conf

# Bluetooth
AddPackage bluetui # TUI for managing bluetooth devices
AddPackage bluez # Daemons for the bluetooth protocol stack
AddPackage bluez-utils # Development and debugging utilities for the bluetooth protocol stack
SystemdEnable bluez /usr/lib/systemd/system/bluetooth.service