if IsRedmiBookPro; then
    CopyFile /etc/systemd/system/fix-bitland-suspend.service
    SystemdEnable --from-file /etc/systemd/system/fix-bitland-suspend.service

    CopyFile /usr/local/bin/set_charge_limit.sh 755
    CopyFile /etc/systemd/system/battery-charge-limit.service
    SystemdEnable --from-file /etc/systemd/system/battery-charge-limit.service
fi


