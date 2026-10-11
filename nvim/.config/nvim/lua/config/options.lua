-- lua/config/options.lua
local opt = vim.opt

-- Appearance
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"          -- fixed gutter: no text shifting when git/diagnostic signs appear
opt.laststatus = 3              -- one global statusline (lualine will own it)
opt.showmode = false            -- mode is shown in the statusline instead
opt.winborder = "rounded"       -- native rounded borders for every floating window (0.11+)
opt.pumheight = 10              -- completion menu height
opt.fillchars = { eob = " " }   -- hide the ~ on empty lines
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Editing
opt.expandtab = true            -- YAML/HCL default; Go's ftplugin switches back to tabs
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftround = true
opt.smartindent = true
opt.breakindent = true
opt.wrap = false
opt.virtualedit = "block"       -- free-form rectangles in visual-block mode
opt.confirm = true              -- ask instead of failing on :q with unsaved changes

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"        -- live preview of :s substitutions

-- Splits & scrolling
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.smoothscroll = true

-- Files & undo
opt.undofile = true             -- persistent undo across sessions
opt.swapfile = false
opt.autoread = true             -- pick up changes made outside (git checkout, kubectl edit…)

-- Responsiveness
opt.updatetime = 250
opt.timeoutlen = 300            -- which-key pops up quickly

-- Mouse & clipboard
opt.mouse = "a"
-- Deferred: the clipboard provider probe costs startup time.
-- On Pop!_OS (Wayland) this needs `wl-clipboard`; on macOS it works out of the box.
vim.schedule(function() opt.clipboard = "unnamedplus" end)
