# Dotfiles

This repo contains my personal configuration for Linux with Cosmic.


## Installing Packages and Tools

To set up the dotfiles on a new system, run one of the setup scripts located at `.config/script` folder.


```bash
# Considering an Arch based distro...
cd .config/scripts/
chmod u+x setup_arch.sh
./setup_arch.sh
```


```bash
# Considering an Ubuntu based distro... such as Pop-OS
cd .config/scripts/
chmod u+x setup_ubuntu.sh
./setup_ubuntu.sh
```
Some tools such as `ASDF` will be installed in: `~/Tools/`.

**OBS**:
- the `autoremove.sh` and `cleanup.sh` are only for Arch-based distros.
- I like to install some packages via Flatpack and there will not be in the scripts.

## Configuration

Copy (or create symbolic links) the files in `.config` to your `$HOME/.config` directory (save a backup from the previous configuration is highly recommended).

Once you are inside the project root directory, run:

```bash
cp -r .config/* $HOME/.config/
```

## Theme & Appearance
- Color Scheme: [Tokyo Night Storm](https://github.com/tokyo-night/tokyo-night-vscode-theme)
- Cosmic Settings:
    - Accent color: `#7DCFFF`
    - Window background: `#24283B`
- Wallpapers: they are located in the `wallpapers` directory.

## Apps & Tools
- Cosmic          | Desktop Environment
- Firefox         | Browser
- Thunderbird     | Mail Client
- ZSH + Oh-My-ZSH | Shell
- Vim             | Text Editor
- Oh-My-Posh      | Prompt
- ASDF            | Tool version manager
