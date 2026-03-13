#!/bin/bash

appname="ibus-monitor"
scriptname="ibus-monitor.sh"
unitname="ibus-monitor.service"

if [ "$EUID" -eq 0 ]; then
    scriptpath="/usr/local/bin/"
    unitpath="/etc/systemd/user/"
    unitscope="global"
else
    scriptpath="~/.local/bin/"
    unitpath="~/.config/systemd/user/"
    unitscope="user"
fi

if [ "$1" = "uninstall"]; then
    systemctl --$unitscope disable --now $unitname
    rm -f $unitpath$unitname
    rm -f $scriptpath$scriptname
    systemctl --$unitscope daemon-reload
    systemctl --$unitscope reset-failed
    echo "$appname has been uninstalled. ($unitscope mode)"
else
    mkdir -p $scriptpath $unitpath
    
    wget -qO $scriptpath$scriptname https://github.com/Ryoya15/ibus-monitor/raw/refs/heads/main/$scriptname
    chmod +x $scriptpath$scriptname

    wget -qO $unitpath$unitname https://github.com/Ryoya15/ibus-monitor/raw/refs/heads/main/$unitname

    systemctl --$unitscope daemon-reload
    systemctl --$unitscope enable $unitname
    systemctl --$unitscope restart $unitname
    echo "$appname has been installed. ($unitscope mode)"
fi