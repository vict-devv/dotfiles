#!/usr/bin/env bash

_checkCommandExists() {
    cmd="$1"
    if ! command -v "$cmd" >/dev/null; then
        echo 1
        return
    fi
    echo 0
    return
}

_isInstalled() {
    package="$1"
    check="$($aur_helper -Qs --color always "${package}" | grep "local" | grep "${package} ")"

    if [ -n "${check}" ]; then
        echo 0
        return #true
    fi

    echo 1
    return #false
}

# confirm start...
sleep 1
clear
figlet -f smslant "Updates"
echo
primarycolor=$(cat ~/.config/colors/primary)
onsurfacecolor=$(cat ~/.config/colors/onsurface)
if gum confirm --selected.background=$primarycolor --prompt.foreground=$onsurfacecolor "DO YOU WANT TO START THE UPDATE NOW?"; then
    echo
    echo ":: Update started..."
elif [ $? -eq 130 ]; then
    exit 130
else
    echo
    echo ":: Update canceled."
    exit
fi

# install..
yay_installed="false"
paru_installed="false"
if [[ $(_checkCommandExists "yay") == 0 ]]; then
    yay_installed="true"
fi
if [[ $(_checkCommandExists "paru") == 0 ]]; then
    paru_installed="true"
fi
if [[ $yay_installed == "true" ]] && [[ $paru_installed == "false" ]]; then
    yay
elif [[ $yay_installed == "false" ]] && [[ $paru_installed == "true" ]]; then
    paru -Syu --noconfirm
else
    yay
fi

# flatpak updates...
if [[ $(_checkCommandExists "flatpak") == 1 ]]; then
    echo ":: Searching for Flatpak updates..."
    flatpak update
    echo
fi

# snap updates...
if [[ $(_checkCommandExists "snap") == 1 ]]; then
    echo ":: Searching for Snap updates..."
    sudo snap refresh
    echo
fi

echo ":: Update complete! Press [ENTER] to close."
read