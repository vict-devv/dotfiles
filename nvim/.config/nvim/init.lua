-- ~/.config/nvim/init.lua
-- Entry point: leaders first, then core config, then plugins.

-- Leaders must be set before lazy.nvim loads any plugin mappings.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.filetypes")
require("config.keymaps")
require("config.autocmds")

-- ── Bootstrap lazy.nvim ────────────────────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- ── Plugins ────────────────────────────────────────────────────────────
-- Every file in lua/plugins/ returns a spec (or a list of specs).
require("lazy").setup({
  spec = { { import = "plugins" } },
  defaults = { lazy = true },               -- opt-in loading: plugins declare their own triggers
  install = { colorscheme = { "tokyonight-night", "habamax" } },
  checker = { enabled = false },            -- update manually with :Lazy update
  change_detection = { notify = false },
  ui = { border = "rounded" },
  performance = {
    rtp = {
      -- Built-in plugins we never use. netrw stays until oil.nvim is added.
      disabled_plugins = {
        "gzip", "tarPlugin", "zipPlugin", "tohtml", "tutor",
      },
    },
  },
})
