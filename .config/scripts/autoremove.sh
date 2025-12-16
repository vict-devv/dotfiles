#!/bin/bash
figlet -f smslant "AutoRemove"
echo

yay -Qqdt

if [ $? -ne 0 ]; then
    echo "Nothing to be removed."
else
    $? | yay -Rsu
    echo "Autoremove completed successfully."
fi

exit 0
