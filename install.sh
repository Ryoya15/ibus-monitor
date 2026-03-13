#!/bin/bash

appname=ibus-monitor
scriptname=ibus-monitor.sh
unitname=ibus-monitor.service

if [ "$EUID" -eq 0 ]; then
    scriptpath=/usr/local/bin/
    unitpath=/etc/systemd/user/
    unitscope=global
else
    scriptpath=~/.local/bin/
    unitpath=~/.config/systemd/user/
    unitscope=user
fi

if [ "$1" = "uninstall" ]; then
    systemctl --$unitscope disable --now $unitname

    rm -f $unitpath$unitname $scriptpath$scriptname

    echo "$appname has been uninstalled. ($unitscope mode)"
else
    mkdir -p $scriptpath $unitpath
    
    wget -qO $scriptpath$scriptname https://github.com/Ryoya15/ibus-monitor/raw/refs/heads/main/$scriptname
    chmod +x $scriptpath$scriptname

    wget -qO $unitpath$unitname https://github.com/Ryoya15/ibus-monitor/raw/refs/heads/main/$unitname
    [ "$unitscope" = "global" ] && sed -i "s|%h/.local/bin/|$scriptpath|" $unitpath$unitname

    systemctl --$unitscope enable --now $unitname
    echo "$appname has been installed. ($unitscope mode)"
fi

[ "$unitscope" = "global" ] && echo "System mode cannot operate the current user's unit. Please restart the computer to complete the task."