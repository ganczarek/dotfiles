SetFileProperty / mode 555

CopyFile /etc/default/grub
# Load acpi_call module (e.g. for set_charge_limit.sh)
CopyFile /etc/modules-load.d/acpi_call.conf
CopyFile /etc/nix/nix.conf
CopyFile /etc/security/faillock.conf
CopyFile /etc/sysctl.d/99-reisub.conf