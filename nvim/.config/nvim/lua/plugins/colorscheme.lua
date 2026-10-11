-- lua/plugins/colorscheme.lua
return {
  "folke/tokyonight.nvim",
  lazy = false,       -- the colorscheme must load at startup…
  priority = 1000,    -- …and before every other plugin
  opts = {
    style = "night",  -- darkest variant, matches Tokyo Night Dark
    transparent = false, -- set true if your terminal uses background transparency
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      sidebars = "dark",
      floats = "dark",
    },
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight-night")
  end,
}
