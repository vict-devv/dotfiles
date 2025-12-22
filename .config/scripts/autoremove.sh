#!/bin/bash
figlet -f smslant "AutoRemove"
echo

if [[ $(yay -Qqdt) ==  0 ]]; then
    echo "Nothing to be removed."
else
    yay -Rsu $(yay -Qqdt)
    echo "Autoremove completed successfully."
fi

exit 0
