#!/usr/bin/env sh

repo_regexp='[#;\/]{1,2} @Requires ((?!aur:)\S*)'
aur_regexp='[#;\/]{1,2} @Requires ((?:aur:)\S*)'

get_matches() {
    grep -hrxP "$1" $2 | sort -u | awk '{print $NF}'
}

remove_aur_prefix() {
    sed -r 's/aur://'
}

get_aur_helper() {
    if command -v paru >/dev/null 2>&1; then
        echo paru
    elif command -v yay >/dev/null 2>&1; then
        echo yay
    else
        echo "WARN: No aur helper found - press enter to install paru!" >&2
        read -r
        pushd /tmp || cd /tmp || :
        git clone https://aur.archlinux.org/paru.git >&2
        cd paru || return
        makepkg -si >&2
        popd || :
        echo paru
    fi
}

sudo pacman -S --needed $(get_matches "$repo_regexp" "$@")
$(get_aur_helper) -S --needed $(get_matches "$aur_regexp" "$@" | remove_aur_prefix)
