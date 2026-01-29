#!/usr/bin/env bash

# This setup is for Ubuntu-based distributions - Pop OS!
set -euo pipefail

# Install essential packages
packages=(
    "curl"
    "wget"
    "zip"
    "unzip"
    "tar"
    "build-essential"
    "jq"
    "git"
    "vim"
    "zsh"
    "htop"
    "figlet"
    "fastfetch"
    "firefox"
)

_isInstalled() {
    package="$1"
    check="$(dpkg -l | grep "${package}")"
    if [ -n "${check}" ]; then
        return 0
    fi
    return 1
}

_installPackages() {
    for pkg in "$@"; do
        if [[ $(_isInstalled "${pkg}") == 0 ]]; then
            echo ":: ${pkg} is already installed."
            continue
        fi
        sudo apt-get install -y "${pkg}"
    done
}

_installPackages "${packages[@]}"

_installBibataCursor() {
    if [[ -d $HOME/.local/share/icons ]]; then
        mkdir -p "$HOME/.local/share/icons"
    fi

    if [[ ! -d /usr/share/icons/Bibata-Modern-Ice ]]; then
        bibata="https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Ice.tar.xz"
        wget -P "$HOME/Downloads" $bibata
        sudo tar -xf "$HOME/Downloads/Bibata-Modern-Ice.tar.xz" -C "/usr/share/icons"
    fi

    gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Ice"
    gsettings set org.gnome.desktop.interface cursor-size 24

    trap 'rm -f "$HOME/Downloads/Bibata-Modern-Ice.tar.xz"' EXIT
}

_installBibataCursor

# Install Nerd Fonts
_installNerdFonts() {
    # Cascadia Code Nerd Font
    if [[ ! -d $HOME/.local/share/fonts/cascadia-code ]]; then
        mkdir -p "$HOME/.local/share/fonts/cascadia-code"
        wget -P "$HOME/Downloads" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CascadiaCode.zip"
        unzip "$HOME/Downloads/CascadiaCode.zip" -d "$HOME/.local/share/fonts/cascadia-code"
    fi

    # JetBrains Mono Nerd Font
    if [[ ! -d $HOME/.local/share/fonts/jetbrains-mono ]]; then
        mkdir -p "$HOME/.local/share/fonts/jetbrains-mono"
        wget -P "$HOME/Downloads" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"
        unzip "$HOME/Downloads/JetBrainsMono.zip" -d "$HOME/.local/share/fonts/jetbrains-mono"
    fi

    fc-cache -fv
    trap 'rm -f "$HOME/Downloads/CascadiaCode.zip"' EXIT
    trap 'rm -f "$HOME/Downloads/JetBrainsMono.zip"' EXIT
}

_installOhMyZsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
    fi

    # autosuggestions and syntax highlighting plugins
    if [ ! -n "$ZSH_CUSTOM" ]; then
        git clone "https://github.com/zsh-users/zsh-autosuggestions.git" "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
        git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    fi
}

_installOhMyZsh

_installOhMyPosh() {
    if [ ! -d "$HOME/.local/bin" ]; then
        mkdir -p "$HOME/.local/bin"
    fi
    curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
}

_installOhMyPosh

_installAsdf() {
    if [ ! -d "$HOME/.asdf" ]; then
        wget -P "$HOME/Downloads" "https://github.com/asdf-vm/asdf/releases/download/v0.18.0/asdf-v0.18.0-linux-386.tar.gz"
        sudo tar -xf "$HOME/Downloads/asdf-v0.18.0-linux-386.tar.gz" -C "/usr/local/bin"
    fi

    trap 'rm -f "$HOME/Downloads/asdf-v0.18.0-linux-386.tar.gz"' EXIT
}

_installAsdf