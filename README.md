# Dotfiles

This repo contains my personal configuration for Linux with Cosmic.


## Installing Packages and Tools

To set up the dotfiles on a new system, run the setup script:

```bash
cd .config/scripts/
chmod u+x setup.sh
./setup.sh
```

Some tools such as `ASDF` will be installed in: `~/Tools/`.

## Configuration

Copy (or create symbolic links) the files in `.config` to your `$HOME/.config` directory (save a backup from the previous configuration is highly recommended).

Once you are inside the project root directory, run:

```bash
cp -r .config/* $HOME/.config/
```

A nit pick that I like to do is change the Terminal launch shortcut from the Cosmic default `Win+T` to `Win+Enter`.

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
