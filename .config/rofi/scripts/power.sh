#!/usr/bin/env sh

rofi_command="rofi"

# Buttons
lock="󰌾 Lock"
logout="󰿅 Log out"
suspend="󰤄 Suspend"
shudown=" Power off"
reboot="󰜉 Reboot"

# countdown
countdown() {
    for sec in $(seq $1 -1 1); do
        dunstify -t 1000 --replace=699 "Taking action in : $sec"
        sleep 1
    done
}

# do actions
dolock() {
    swaylock
}

dologout() {
    countdown 3
    hyprctl dispatch exit
}

dosuspend() {
    systemctl suspend
}

doshutdown() {
    countdown 3
    systemctl poweroff
}

doreboot() {
    countdown 3
    systemctl reboot
}

# Variable passed to rofi
options="$lock\n$logout\n$suspend\n$shudown\n$reboot"

chosen="$(echo -e "$options" | $rofi_command -p 'Power' -dmenu -selected-row 0)"
case $chosen in
    $lock)
        dolock
        ;;
    $logout)
        dologout
        ;;
    $suspend)
        dosuspend
        ;;
    $shudown)
        doshutdown
        ;;
    $reboot)
        doreboot
        ;;
esac
