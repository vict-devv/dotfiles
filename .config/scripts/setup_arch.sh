#!/usr/bin/env bash

# This setup is for Arch-based distributions
set -euo pipefail

# Install essential packages
packages=(
    "curl"
    "wget"
    "zip"
    "unzip"
    "tar"
    "base-devel"
    "jq"
    "git"
    "vim"
    "zsh"
    "htop"
    "docker"
    "docker-compose"
    "xclip"
    "figlet"
    "fastfetch"
    "gnome-keyring"
    "firefox"
    "cosmic-viewer-git"
    "cosmic-ext-calculator-git"
    "thunderbird"
    "visual-studio-code-bin"
    "ttf-fira-sans"
    "ttf-jetbrains-mono-nerd"
    "ttf-cascadia-code-nerd"
)

_isInstalled() {
    package="$1"
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")"
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
        yay --noconfirm -S "${pkg}"
    done
}

_installPackages "${packages[@]}"


_installBibataCursor() {
    if [[ -d $HOME/.local/share/icons ]]; then
        mkdir -p "$HOME/.local/share/icons"
    fi
        bibata="https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Ice.tar.xz"
        wget -P "$HOME/Downloads" $bibata 
        tar -xf "$HOME/Downloads/Bibata-Modern-Ice.tar.xz" -C "$HOME/.local/share/icons"

    gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Ice"
    gsettings set org.gnome.desktop.interface cursor-size 24

    trap 'rm -f "$HOME/Downloads/Bibata-Modern-Ice.tar.xz"' EXIT
}

_installBibataCursor


# Create Tools directory
if [[ -d $HOME/Tools ]]; then
    mkdir -p "$HOME/Tools"
fi

_installYay() {
    if [ -d "$HOME/Tools/yay" ]; then
        echo ":: yay is already installed."
        return
    fi

    SCRIPT=$(realpath "$0")
    temp_path=$(dirname "$SCRIPT")

    git clone https://aur.archlinux.org/yay-bin.git "$HOME/Tools/yay"
    cd "$HOME/Tools/yay" || exit 1
    makepkg -si

    cd "$temp_path" || exit 1
    echo ":: yay has been installed successfully."
}

_installYay

_installAsdf() {
    if [ -d "$HOME/Tools/asdf" ]; then
        echo ":: asdf is already installed."
        return
    fi

    SCRIPT=$(realpath "$0")
    temp_path=$(dirname "$SCRIPT")

    git clone https://aur.archlinux.org/asdf-vm.git "$HOME/Tools/asdf-vm"
    cd "$HOME/Tools/asdf-vm" || exit 1
    makepkg -si

    cd "$temp_path" || exit 1
    echo ":: asdf has been installed successfully."
}

_installAsdf

_isInstalled() {
    package="$1"
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")"
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
        yay --noconfirm -S "${pkg}"
    done
}

_installPackages "${packages[@]}"

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
