# dotfiles

Personal dotfiles for my Arch Linux setup.

## System

| Component        | Choice                              |
|------------------|-------------------------------------|
| OS               | Arch Linux                          |
| Compositor       | [Niri](https://github.com/YaLTeR/niri) (Wayland, scrolling tiling) |
| Shell UI         | [Noctalia](https://noctalia.app) (QuickShell-based) |
| Login Manager    | SDDM                                |
| Terminal         | Alacritty                           |
| Shell            | Zsh + Oh My Zsh + Starship          |
| Multiplexer      | tmux                                |
| Editor           | Vim, VS Code                        |
| Browser          | Firefox                             |
| File Manager     | Nautilus                            |
| Color Theme      | Everforest (Dark)                   |
| Font             | Caskaydia Cove NF (terminal), Ubuntu Nerd Font (UI) |
| Cursor           | Bibata-Modern-Ice                   |

## What's Included

```
.gitconfig                          # Git config (aliases, SSH signing via 1Password)
.vimrc                              # Vim config (keymaps, plugins, Everforest theme)
.zshrc                              # Zsh config (Oh My Zsh, Starship, aliases)
.tmux.conf                          # tmux config with Everforest theme
.config/
  alacritty/
    alacritty.toml                  # Terminal config (font, opacity, theme import)
    themes/noctalia.toml            # Noctalia-generated Alacritty colorscheme
  claude/
    everforest-dark.json            # Everforest Dark color theme for Claude Code CLI
  fastfetch/config.jsonc            # Fetch display with custom card layout
  niri/
    config.kdl                      # Compositor config (keybinds, outputs, rules)
    noctalia.kdl                    # Noctalia-generated Niri colors
  noctalia/
    settings.json                   # Noctalia shell settings (bar, launcher, etc.)
    colors.json                     # Active color configuration
    colorschemes/Everforest/        # Everforest colorscheme definition
    notification-rules.json         # Notification filtering rules
    plugins.json                    # Installed plugins list
    plugins/clipper/                # Clipper plugin (clipboard history + notecards)
  scripts/
    asdf_install_latest_versions.sh # Install latest asdf-managed tool versions
    asdf_uninstall_old_versions.sh  # Clean up old asdf tool versions
  starship.toml                     # Starship prompt config with Noctalia palette
  vscode/
    settings.json                   # VS Code settings (Vim keybindings, Everforest theme, formatting)
    keybindings.json                # Custom keybindings
    extensions.txt                  # Installed extensions list
wallpapers/                         # Everforest wallpaper + lockscreen
```

## Niri Keybinds

`Mod` = Super key.

| Keybind              | Action                          |
|----------------------|---------------------------------|
| `Mod+T`              | Open terminal (Alacritty)       |
| `Mod+B`              | Open browser (Firefox)          |
| `Mod+D`              | App launcher                    |
| `Mod+E`              | File manager (Nautilus)         |
| `Mod+S`              | Noctalia settings               |
| `Mod+Q`              | Close window                    |
| `Mod+F`              | Fullscreen                      |
| `Mod+M`              | Maximize to edges               |
| `Mod+V`              | Toggle floating                 |
| `Mod+O`              | Toggle overview                 |
| `Mod+C`              | Center column                   |
| `Mod+R`              | Cycle column width preset       |
| `Mod+H/L`            | Focus column left/right         |
| `Mod+J/K`            | Focus window/workspace up-down  |
| `Mod+Ctrl+H/L`       | Focus monitor left/right        |
| `Mod+1–9`            | Switch to workspace             |
| `Mod+Ctrl+1–9`       | Move column to workspace        |
| `Mod+Escape`         | Lock screen                     |
| `Mod+Shift+Escape`   | Session menu                    |
| `Print`              | Screenshot (region)             |
| `Ctrl+Print`         | Screenshot (screen)             |
| `Alt+Print`          | Screenshot (window)             |
| `Mod+Shift+/`        | Show hotkey overlay             |

## Zsh Aliases

| Alias  | Expands to                        |
|--------|-----------------------------------|
| `ls`   | `eza --icons=always`              |
| `lsa`  | `eza -A --icons=always`           |
| `ll`   | `eza -l --icons=always`           |
| `lla`  | `eza -lA --icons=always`          |
| `cat`  | `bat --theme=ansi`                |
| `catc` | `bat --theme=ansi --paging=never` |
| `ff`   | `fastfetch`                       |
| `vi`   | `$EDITOR` (vim)                   |
| `c`    | `clear`                           |

## Vim Keymaps

`<leader>` = Space.

| Keymap            | Mode   | Action                          |
|-------------------|--------|---------------------------------|
| `jk`              | Insert | Escape to normal mode           |
| `<Esc>`           | Normal | Clear search highlights         |
| `n` / `N`         | Normal | Next/prev match (centered)      |
| `<leader>w`       | Normal | Save file                       |
| `<leader>q`       | Normal | Quit                            |
| `<leader>rn`      | Normal | Toggle relative line numbers    |
| `<leader>h/j/k/l` | Normal | Focus split left/down/up/right  |
| `<leader>sv`      | Normal | Vertical split                  |
| `<leader>sh`      | Normal | Horizontal split                |
| `<leader>e`       | Normal | Open Netrw explorer             |
| `<leader>ff`      | Normal | FZF: find files                 |
| `<leader>fg`      | Normal | FZF: live grep (ripgrep)        |
| `<leader>fb`      | Normal | FZF: list buffers               |
| `]d` / `[d`       | Normal | Next/prev ALE diagnostic        |
| `<leader>a`       | Normal | ALE: show diagnostic detail     |
| `<leader>gb`      | Normal | Git blame                       |

## Vim Plugins

- `sainnhe/everforest` — Everforest color theme
- `tpope/vim-fugitive` — Git integration
- `airblade/vim-gitgutter` — Git diff signs in the gutter
- `junegunn/fzf` + `fzf.vim` — Fuzzy finder (files, grep, buffers)
- `tpope/vim-surround` — Surround text objects
- `sheerun/vim-polyglot` — Language pack
- `dense-analysis/ale` — Async linting + fixing (shellcheck, hadolint, tflint, ansible-lint)
- `hashivim/vim-terraform` — Terraform filetype support
- `pearofducks/ansible-vim` — Ansible filetype support
- `machakann/vim-highlightedyank` — Briefly highlight yanked text

## Oh My Zsh Plugins

- `asdf` — version manager integration
- `fzf` — fuzzy finder
- `git` — git aliases and completions
- `kubectl` — Kubernetes completions
- `sudo` — press Esc twice to prefix command with `sudo`
- `copybuffer` — `Ctrl+O` copies current terminal buffer to clipboard
- `copyfile` / `copypath` — copy file contents or path to clipboard
- `zsh-autosuggestions` / `zsh-syntax-highlighting`

## Noctalia Templates

Noctalia auto-generates and syncs the colorscheme across: Alacritty, GTK, Fuzzel, Qt, Niri, Discord, btop, Pywalfox, Starship, and VS Code.
