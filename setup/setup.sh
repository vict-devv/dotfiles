#!/usr/bin/env bash

general=(
    "wget"
    "curl"
    "git"
    "zip"
    "unzip"
    "tar"
    "jq"
    "vim"
    "inotify-tools"
)

hyprland=(
    "hyprpaper"
    "hyprlock"
    "hypridle"
    "hyprpicker"
    "xdg-desktop-portal-hyprland"
    "uwsm"
    "libnewt"
)

apps=(
    "kitty"
    "wlogout"
    "vlc"
    "waybar"
    "rofi-wayland"
    "nwg-look"
    "pavucontrol"
    "blueman"
    "qt6ct"
    "nautilus"
    "firefox"
    "google-chrome"
)

tools=(
    "xdg-user-dirs"    
    "xdg-desktop-portal-gtk"    
    "fastfetch"
    "htop"
    "xclip"
    "zsh"
    "fzf"
    "brightnessctl"
    "tumbler"
    "slurp"
    "cliphist"
    "gvfs"
    "grim"
    "breeze"
    "matugen-bin"
)

packages=(
    "hyprland"
    "libnotify"
    "qt5-wayland"
    "qt6-wayland"
    "uwsm"
    "python-pip"
    "python-gobject"
    "python-screeninfo"
    "nm-connection-editor"
    "network-manager-applet"
    "imagemagick"
    "polkit-gnome"
    "hyprshade"
    "grimblast-git"
    "pacman-contrib"
    "loupe"
    "power-profiles-daemon"
    "waypaper"
    "swaync"
    "otf-font-awesome"
    "ttf-fira-sans"
    "ttf-jetbrains-mono-nerd"
    "tty-clock"
    "qt5-graphicaleffects"
    "qt5-qtquickcontrols2"
    "qt5-qtsvg"
)

_installBibataCursor() {
    if [[ -d $HOME/.local/share/icons ]]
        mkdir -p $HOME/.local/share/icons
    fi
        bibata="https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Ice.tar.xz"
        wget -P $HOME/Downloads $bibata 
        tar -xf $HOME/Downloads/Bibata-Modern-Ice.tar.xz -C $HOME/.local/share/icons
}

_installYay() {
    if [[ ! $(_isInstalled "base-devel") == 0 ]]; then
        sudo pacman --noconfirm -S "base-devel"
    fi
    if [[ ! $(_isInstalled "git") == 0 ]]; then
        sudo pacman --noconfirm -S "git"
    fi
    if [[ -d $HOME/Tools ]]; then
        mkdir -p $HOME/Tools
    fi
    if [ -d $HOME/Tools/yay ]; then
        rm -rf $HOME/Tools/yay
    fi
    SCRIPT=$(realpath "$0")
    temp_path=$(dirname "$SCRIPT")
    git clone https://aur.archlinux.org/yay-bin.git $HOME/Tools/yay
    cd $HOME/Tools/yay
    makepkg -si
    cd $temp_path
    echo ":: yay has been installed successfully."
}

_installYay

_isInstalled() {
    package="$1"
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")"
    if [ -n "${check}" ]; then
        echo 0
        return #true
    fi
    echo 1
    return #false
}

_installPackages() {
    for pkg; do
        if [[ $(_isInstalled "${pkg}") == 0 ]]; then
            echo ":: ${pkg} is already installed."
            continue
        fi
        yay --noconfirm -S "${pkg}"
    done
}

_checkCommandExists() {
    cmd="$1"
    if ! command -v "$cmd" >/dev/null; then
        echo 1
        return
    fi
    echo 0
    return
}

# install gum
if [[ $(_checkCommandExists "gum") == 0 ]]; then
    echo ":: gum is already installed"
else
    echo ":: The installer requires gum. gum will be installed now"
    sudo pacman --noconfirm -S gum
fi

# install packages
_installPackages "${general[@]}"
_installPackages "${hyprland[@]}"
_installPackages "${apps[@]}"
_installPackages "${tools[@]}"
_installPackages "${packages[@]}"

# install oh-my-zsh
if [ ! -d $HOME/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
fi

# install oh-my-posh
if [ ! -d $HOME/.local/bin ]; then
    mkdir -p $HOME/.local/bin
fi
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
