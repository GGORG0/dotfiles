#!/usr/bin/env sh

paru -Syu --noconfirm
flatpak update -y
pkill -SIGRTMIN+8 waybar
