#!/bin/bash
figlet -f smslant "Cleanup"
echo

_checkYay() {
    if ! command -v yay &> /dev/null; then
        echo "yay could not be found, please install it first."
        exit 1
    fi
}

_checkYay

yay -Scc
