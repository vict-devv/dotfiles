# Dotfiles

This repo contains my personal dotfiles for configuring Arch + Hyprland system.

## Installating Packages

To set up the dotfiles on a new system, run the setup script:

```bash
sh setup/setup.sh
```

## Configuration

You can either copy the configuration files manually or use symbolic links to point to the dotfiles in this repository.

Everything is located in the `~/.config/` directory.

To work with wallpaper and the lock screen the following files need to exists:

- `~/Pictures/Wallpaper/wallpaper.png`
- `~/Pictures/profile.png`

The setup only works with PNG files for now.

Some tools such as `Yay` will be setup in the following directory: `~/Tools/`.

```bash
cp -r path/to/dotfiles/.config/* ~/.config/
```

## Themes
- Icons: [Goldy-Dark-Icon](https://www.gnome-look.org/p/2037378)

## Tools

- Kitty
- Hyperland
- Vim
- Fastfetch
- Matugen
- Rofi
- Swaync
- Waybar
- Oh My Posh

## Credits

I've used the ML4W's dotfiles setup as a reference for creating my own dotfiles.
Removing and adapt things to fit my preferences and workflow.

You can find their repository [here](https://github.com/ML4W/dotfiles).
