#!/usr/bin/env bash

declare -A LISTENERS=(
    ["low-battery"]="$HOME/.config/scripts/low-battery-notify.sh"
)

for listener in "${!LISTENERS[@]}"; do
    script="${LISTENERS[$listener]}"
    if pgrep -f "$script" > /dev/null; then
        echo "$listener listener is already running."
    else
        echo "Starting $listener listener..."
        nohup bash "$script" >/dev/null 2>&1 &
    fi
done