#!/usr/bin/env bash

# get the number of pacman + aur + flatpak updates
export CHECKUPDATES_DB="${TMPDIR:-/tmp}/checkup-db-${UID}-waybar"
checkupdates &>/dev/null

pac=$(paru -Quq -b "$CHECKUPDATES_DB")
flat=$(flatpak remote-ls --columns=application -a --updates)

pac_cnt=$(echo -n "$pac" | wc -l)
flat_cnt=$(echo -n "$flat" | wc -l)

# sum them up
updates=$((pac_cnt + flat_cnt))

# if there are updates, show them
if [ "$updates" -gt 0 ]; then
    text="$updates 󰏕"
else
    text=""
fi

tooltip="$(echo -en "$pac\n$flat")"

# print them in a format known for waybar
jq --unbuffered --null-input --compact-output \
    --arg text "$text" \
    --arg tooltip "$tooltip" \
    '{"text": $text, "tooltip": $tooltip}'
