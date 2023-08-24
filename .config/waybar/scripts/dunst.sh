#!/bin/bash
set -euo pipefail

ENABLED=
DISABLED=
DISABLED_UNREAD=

dbus-monitor path='/org/freedesktop/Notifications',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged' --profile |
    while read -r _; do
        PAUSED="$(dunstctl is-paused)"
        if [ "$PAUSED" == 'false' ]; then
            TEXT="$ENABLED "
        else
            TEXT="$DISABLED "
            COUNT="$(dunstctl count waiting)"
            if [ "$COUNT" != '0' ]; then
                TEXT="$COUNT $DISABLED_UNREAD "
            fi
        fi
        printf '{"text": "%s"}\n' "$TEXT"
    done
