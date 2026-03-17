#!/bin/bash
set -eo pipefail
test -x /usr/bin/ibus
journalctl /usr/bin/gnome-shell -qfo cat | while read -r line; do
    if [[ "$line" == *"Gio.DBusError: GDBus.Error:org.freedesktop.DBus.Error.Failed: Set global engine failed"* ]]; then
        echo "IBus semi-crash detected. Restarting..."
        ibus restart
        sleep 1
    fi
done