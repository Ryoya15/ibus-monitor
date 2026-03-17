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
    systemctl --$unitscope disable --now $unitname 2>/dev/null

    rm -f $unitpath$unitname $scriptpath$scriptname

    echo "$appname has been uninstalled ($unitscope)."
else
    mkdir -p $scriptpath $unitpath

    download(){
        # $1=source(filename only)
        # $2=destination(fullpath)
        urlprefix=https://github.com/Ryoya15/ibus-monitor/raw/refs/heads/main/
        localprefix=$(dirname "$0")/
        wget -q "$urlprefix$1" -O "$2" 2>/dev/null || \
        curl -fsL "$urlprefix$1" -o "$2" 2>/dev/null || \
        cp "$localprefix$1" "$2" 2>/dev/null || {
            echo "Error: Unable to retrieve the additional files. If you are not connected to the Internet or cannot use either wget or curl, please run install.sh from the downloaded source code."
            exit 1
        }
    }
    
    download $scriptname $scriptpath$scriptname
    chmod +x $scriptpath$scriptname

    download $unitname $unitpath$unitname
    [ "$unitscope" = "global" ] && sed -i "s|%h/.local/bin/|$scriptpath|" $unitpath$unitname

    systemctl --$unitscope enable --now $unitname 2>/dev/null
    
    echo "$appname has been installed ($unitscope)."
fi

[ "$unitscope" = "global" ] && echo "A restart is required for this change to take full effect."