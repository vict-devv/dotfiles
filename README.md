# dotfiles

Personal configuration for a minimal, Tokyo Night–themed DevOps workstation, shared between Pop!_OS (COSMIC) and macOS. Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

Each top-level folder is a **Stow package**. Inside it is the path the files should have relative to `~`.

| Package | Links to | Platforms | Notes |
|---|---|---|---|
| `nvim` | `~/.config/nvim` | Linux · macOS | Neovim from scratch on lazy.nvim. See its [README](nvim/.config/nvim/README.md) |
| `tmux` | `~/.config/tmux` | Linux · macOS | `Ctrl+A` prefix, vim-tmux-navigator, Tokyo Night status bar |
| `fastfetch` | `~/.config/fastfetch` | Linux · macOS | System info on shell start |
| `cosmic` | `~/.config/cosmic` | Linux only | COSMIC desktop: theme, panel, shortcuts |

```
dotfiles/
├── .stowrc                                   # makes ~ the target, wherever the repo lives
├── nvim/.config/nvim/...
├── tmux/.config/tmux/tmux.conf
├── fastfetch/.config/fastfetch/config.jsonc
└── cosmic/.config/cosmic/...
```

## Setup on a new machine

**1. Install Stow**

```bash
sudo apt install stow      # Pop!_OS / Debian / Ubuntu
brew install stow          # macOS
```

**2. Clone the repo.** It can live anywhere, because `.stowrc` points Stow at `~`.

```bash
git clone git@github.com:<your-user>/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles
```

**3. Move any existing configs out of the way.** Stow never overwrites real files; it stops with a conflict instead.

```bash
mv ~/.config/nvim ~/.config/nvim.bak   # repeat for each package you'll stow
```

**4. Link the packages for this machine**

```bash
stow -nv nvim tmux fastfetch cosmic   # dry run: shows what would be linked
stow -v  nvim tmux fastfetch cosmic   # Pop!_OS
stow -v  nvim tmux fastfetch          # macOS (no COSMIC)
```

**5. Check the result**

```bash
ls -l ~/.config | grep -- '->'   # each linked folder points into the repo
```

## How Stow works here

Stow creates **symlinks** from `~` into the repo. Running `stow nvim` mirrors `nvim/.config/nvim` as `~/.config/nvim → ~/Projects/dotfiles/nvim/.config/nvim`. Because of this:

- Editing `~/.config/nvim/...` edits the repo directly. There's nothing to copy back, just commit.
- Files a tool creates inside its folder (Neovim's `lazy-lock.json`, for example) land in the repo automatically.
- `.stowrc` contains `--target=~`. Without it, Stow would link into the repo's parent folder (`~/Projects`), not your home.

## Everyday commands

Run these from the repo root.

| Command | What it does |
|---|---|
| `stow -nv <pkg>` | Dry run: preview the links, change nothing |
| `stow <pkg>` | Link a package |
| `stow -D <pkg>` | Unlink a package (the repo files are untouched) |
| `stow -R <pkg>` | Re-link, after adding, moving or deleting files in a package |

## Adding a new tool

```bash
cd ~/Projects/dotfiles
mkdir -p kitty/.config                 # package name + the path relative to ~
mv ~/.config/kitty kitty/.config/      # move the real config into the repo
stow -v kitty                          # link it back
git add kitty && git commit -m "Add kitty config"
```

A file that lives directly in `~` follows the same rule: `zsh/.zshrc` links to `~/.zshrc`.

## Syncing between machines

```bash
git pull               # get changes made on the other machine
stow -R <pkg>          # only needed if files were added or removed in a package
```

## Notes

- **Never commit secrets.** Some tools keep tokens in `~/.config` (for example `gh/hosts.yml`). Only add packages you've checked, and add `.gitignore` rules inside a package for anything sensitive.
- **Avoid `stow --adopt`.** It pulls existing files into the repo and overwrites what's there. Move folders in by hand, as shown above.
- **COSMIC rewrites its config often** (panel and window state). Expect frequent diffs in `cosmic/`. Commit the changes you mean to keep and `git restore` the rest.
