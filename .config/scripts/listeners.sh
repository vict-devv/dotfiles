#!/usr/bin/env bash

declare -A LISTENERS=(
    ["low-battery"]="$HOME/.config/scripts/low-battery-notify.sh"
)

start_listener() {
    local script_name="$1"
    local init_flag="$2"
    local script_path="${LISTENERS[$script_name]}"

    if [ -z "$script_path" ]; then
        echo "Error: Listener '$script_name' is not registered."
        return 1
    fi

    echo "Attempting to start '$script_name'..."

    # check if the script file exists and is executable
    if [ ! -f "$script_path" ]; then
        echo "Error: Script file '$script_path' not found for '$script_name'."
        return 1
    fi
    if [ ! -x "$script_path" ]; then
        echo "Error: Script file '$script_path' is not executable. Please run 'chmod +x \"$script_path\"'."
        return 1
    fi

    # check if the script is already running
    if pgrep -f "$script_path" >/dev/null; then
        echo "Listener '$script_name' is already running (PID: $(pgrep -f "$script_path"))."
        return 0
    fi

    # start the script in the background using nohup to detach it from the terminal
    # redirect stdout and stderr to /dev/null to prevent nohup.out files
    nohup "$script_path" "$init_flag" >/dev/null 2>&1 &
    echo "Listener '$script_name' started successfully."
}

stop_listener() {
    local script_name="$1"
    local script_path="${LISTENERS[$script_name]}"

    if [ -z "$script_path" ]; then
        echo "Error: Listener '$script_name' is not registered."
        return 1
    fi

    echo "Attempting to stop '$script_name'..."

    # find the pid of the running script
    local pid=$(pgrep -f "$script_path")

    if [ -z "$pid" ]; then
        echo "Listener '$script_name' is not running."
        return 0
    else
        echo "Found PID(s) for '$script_name': $pid. Sending SIGTERM..."
        kill $pid
        # give it a moment to terminate gracefully
        sleep 1
        if pgrep -f "$script_path" >/dev/null; then
            echo "Listener '$script_name' did not stop gracefully. Sending SIGKILL..."
            kill -9 $pid
            echo "Listener '$script_name' forcefully stopped."
        else
            echo "Listener '$script_name' stopped successfully."
        fi
    fi
}

case "$1" in
--startall)
    echo "Starting all registered listeners..."
    for key in "${!LISTENERS[@]}"; do
        start_listener "$key"
    done
    echo "All registered listeners processed."
    ;;
--stopall)
    echo "Stopping all registered listeners..."
    for key in "${!LISTENERS[@]}"; do
        stop_listener "$key"
    done
    echo "All registered listeners processed."
    ;;
*)
    echo "Usage: $0 [--startall | --stopall ]"
    echo ""
    echo "Registered listeners:"
    for key in "${!LISTENERS[@]}"; do
        echo "  - $key"
    done
    exit 1
    ;;
esac