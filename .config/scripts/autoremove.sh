#!/bin/bash
figlet -f smslant "AutoRemove"
echo

yay -Qqdt
status=$?

if [[ $($status ==  1 ]]; then
    echo "Nothing to be removed."
else
    yay -Rsu $(yay -Qqdt)
    echo "Autoremove completed successfully."
fi

exit 0
