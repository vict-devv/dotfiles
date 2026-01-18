#!/bin/bash
figlet -f smslant "AutoRemove"
echo

_checkYay() {
    if ! command -v yay &> /dev/null; then
        echo "yay could not be found, please install it first."
        exit 1
    fi
}

_checkYay

yay -Qqdt
status=$?

if [[ $($status ==  1) ]]; then
    echo "Nothing to be removed."
else
    yay -Rsu $(yay -Qqdt)
    echo "Autoremove completed successfully."
fi

exit 0
