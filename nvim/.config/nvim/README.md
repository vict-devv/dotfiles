# nvim

A minimal, fast Neovim setup for DevOps work: Kubernetes manifests, Helm charts, Terraform, CI/CD pipelines and the occasional Go/Python/Rust script. Built from scratch on [lazy.nvim](https://github.com/folke/lazy.nvim) and themed with Tokyo Night.

**Principles:** few plugins, each one earning its place · native Neovim features first (LSP, diagnostics, borders) · lazy-loaded everything · consistent, grouped keymaps · no terminal plugin (tmux does that job).

## Requirements

| | |
|---|---|
| Neovim | **0.12+** |
| Font | A [Nerd Font](https://www.nerdfonts.com/) in your terminal |
| CLI tools | `git`, `ripgrep`, `fd`, `fzf`, `tree-sitter` CLI, a C compiler, `kubectl` |
| Clipboard | Linux/Wayland: `wl-clipboard` · macOS: built in |
| tmux | Navigation block from the companion `tmux.conf` (see [tmux](#tmux)) |

## Install

```bash
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null   # back up any existing config
git clone <this-repo> ~/.config/nvim                # or symlink it from your dotfiles
nvim                                                # lazy.nvim bootstraps and installs everything
```

Plugin versions are pinned in `lazy-lock.json`. Run `:Lazy restore` on a new machine to get exactly the same versions, and `:Lazy update` to upgrade.

## Structure

```
nvim/
├── init.lua              # leaders, core config, lazy.nvim bootstrap
├── lua/config/
│   ├── options.lua       # editor options
│   ├── filetypes.lua     # Terraform & Helm detection
│   ├── keymaps.lua       # core, plugin-independent keymaps
│   ├── autocmds.lua      # yank highlight, reload on change, etc.
│   └── lsp.lua           # diagnostics + vim.lsp.enable()
├── lua/plugins/          # one file per plugin or group of plugins
└── lsp/                  # native per-server LSP configs (no nvim-lspconfig)
```

## Plugins

| Plugin | What it does |
|---|---|
| **Look & feel** | |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Colorscheme, `night` style |
| [mini.icons](https://github.com/nvim-mini/mini.icons) | File and filetype icons (also stands in for nvim-web-devicons) |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Shows available keymaps as you type |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Renders Markdown in the buffer |
| **Kubernetes** | |
| [kubectl.nvim](https://github.com/Ramilito/kubectl.nvim) | Browse and troubleshoot clusters in a buffer, vikube style |
| **Editing intelligence** | |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting, indentation, folding |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | Installs LSP servers, formatters and linters |
| [SchemaStore.nvim](https://github.com/b0o/SchemaStore.nvim) | JSON/YAML schemas: Kubernetes, GitHub Actions, GitLab CI, Compose… |
| [blink.cmp](https://github.com/Saghen/blink.cmp) | Completion |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Format on save |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Linters (actionlint, hadolint, tflint…) |
| **Navigation** | |
| [fzf-lua](https://github.com/ibhagwan/fzf-lua) | Fuzzy finder for files, grep, buffers, symbols, git |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | Edit the filesystem like a buffer |
| [aerial.nvim](https://github.com/stevearc/aerial.nvim) | Outline tree and breadcrumbs |
| [flash.nvim](https://github.com/folke/flash.nvim) | Labeled jumps and multi-line `f`/`F`/`t`/`T` |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Same keys for Neovim splits and tmux panes |
| **Git & editing** | |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Hunk signs, staging, blame, diff preview |
| [mini.surround](https://github.com/nvim-mini/mini.surround) | Add, delete and change surrounding characters |
| [mini.ai](https://github.com/nvim-mini/mini.ai) | Extra text objects (arguments, quotes, brackets…) |
| [mini.pairs](https://github.com/nvim-mini/mini.pairs) | Auto-close brackets and quotes |

**Language servers** (installed with Mason, configured natively in `lsp/`): `yamlls`, `helm_ls`, `terraformls`, `bashls`, `dockerls`, `jsonls`, `lua_ls`.

## Keymaps

Leader is `<Space>`. Press it and wait for which-key to show every group.

**The rules**

1. Every `<leader>` key is a group named by a noun.
2. `[x` / `]x` always means previous / next.
3. Native Neovim and well-known plugin keys are kept as they are.

### Leader groups

| Group | Keys |
|---|---|
| `<leader>f` **find** | `ff` files · `fg` grep · `fb` buffers · `fr` recent · `fw` word under cursor · `fh` help · `fk` keymaps |
| `<leader>s` **splits** | `sv` vertical · `sh` horizontal · `se` equalize · `sx` close · `so` only this |
| `<leader>b` **buffers** | `bd` delete · `bo` delete others |
| `<leader>g` **git** | `gs` stage hunk · `gr` reset hunk · `gp` preview hunk · `gb` blame line · `gd` diff · `gS` stage buffer · `gc` commits · `gf` changed files |
| `<leader>c` **code** | `cf` format · `cl` lint · `cd` line diagnostics · `cR` restart LSP |
| `<leader>o` **outline** | `oo` toggle outline · `of` fuzzy symbols · `on` floating navigator |
| `<leader>k` **kubernetes** | `kk` open kubectl.nvim (`g?` inside it for help) |
| `<leader>x` **lists** | `xx` buffer diagnostics · `xX` workspace diagnostics · `xq` quickfix · `xl` location list |
| `<leader>u` **ui toggles** | `uw` wrap · `un` relative numbers · `us` spell · `ud` diagnostics · `uh` inlay hints · `um` markdown rendering |
| `<leader>p` **plugins** | `pl` Lazy · `pm` Mason |
| `<leader>q` **quit** | `qq` quit all |
| single keys | `<leader>w` write · `<leader>e` file explorer · `<leader>?` buffer keymaps |

### Motion & editing

| Keys | Action |
|---|---|
| `s` | Flash jump: type 1–2 chars, then the label (both directions; also works after `d`/`y`/`c`) |
| `S` | Flash Treesitter select: pick an enclosing block by label |
| `f` `F` `t` `T` | Multi-line, highlighted; repeat the key for the next match |
| `gsa` / `gsd` / `gsc` | Surround add / delete / change, e.g. `gsaiw"` · `gsd"` · `gsc"'` |
| `gsf` / `gsF` / `gsh` | Find surrounding right / left · highlight surrounding |
| `a` / `i` text objects | mini.ai: `q` quotes, `b` brackets, `a` arguments, `f` function calls, e.g. `ciq`, `daa` |
| `<C-h/j/k/l>` | Move between Neovim splits and tmux panes |
| `-` | Open the parent directory (oil) |
| `<Esc>` | Clear search highlight |

### LSP (Neovim natives, kept as is)

| Keys | Action |
|---|---|
| `gd` | Go to definition (added) |
| `K` | Hover documentation |
| `grn` · `gra` · `grr` · `gri` | Rename · code action · references · implementation |
| `gO` | Document symbols |
| `[d` / `]d` | Previous / next diagnostic |
| `<C-s>` (insert) | Signature help |

### Next / previous

| Keys | Moves through |
|---|---|
| `[b` `]b` | Buffers |
| `[q` `]q` · `[l` `]l` | Quickfix · location list |
| `[d` `]d` | Diagnostics |
| `[h` `]h` | Git hunks |
| `[o` `]o` | Outline symbols |

### Completion

| Keys | Action |
|---|---|
| `<C-Space>` | Open the menu |
| `<C-n>` / `<C-p>` | Next / previous item |
| `<C-y>` | Accept |
| `<C-e>` | Close |

## tmux

`<C-h/j/k/l>` only works across tmux panes if tmux passes the keys through to Neovim. Add the "Seamless Neovim/tmux navigation" block from the companion `tmux.conf`. Because `<C-l>` then moves between panes, clearing the shell becomes `Prefix` + `<C-l>`.
