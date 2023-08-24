#!/usr/bin/env sh

rofi_command="rofi"

# Buttons
screen="󰍹 Capture screen"
area="󰩬 Capture area"
window=" Capture active window"
infive="󱑀 Take in 3s"
inten="󱑇 Take in 10s"

# Notify and view screenshot
notify() {
    dunstify -u low --replace=699 "Copied to clipboard."
}

# countdown
countdown() {
    for sec in $(seq $1 -1 1); do
        dunstify -t 1000 --replace=699 "Taking shot in : $sec"
        sleep 1
    done
    sleep 0.5
}

# take shots
shotnow() {
    grimblast copy screen
    notify
}

shot5() {
    countdown 3
    grimblast copy screen
    notify
}

shot10() {
    countdown 10
    grimblast copy screen
    notify
}

shotwin() {
    grimblast copy active
    notify
}

shotarea() {
    grimblast copy area
    notify
}

# Variable passed to rofi
options="$screen\n$area\n$window\n$infive\n$inten"

chosen="$(echo -e "$options" | $rofi_command -p 'Take A Shot' -dmenu -selected-row 0)"
sleep 0.75
case $chosen in
    $screen)
        shotnow
        ;;
    $area)
        shotarea
        ;;
    $window)
        shotwin
        ;;
    $infive)
        shot5
        ;;
    $inten)
        shot10
        ;;
esac
