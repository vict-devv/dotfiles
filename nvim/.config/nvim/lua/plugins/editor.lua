-- lua/plugins/editor.lua
return {
  -- Motion: s = labeled jump (both directions), S = Treesitter select,
  -- f/F/t/T = multi-line with highlighted matches (enabled by default).
  -- Works with operators too: ds<label>, ys<label>, cs<label>.
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter select" },
    },
  },

  -- Surround, grouped under gs: gsa add · gsd delete · gsc change
  -- e.g. gsaiw"  →  "word"      gsd"  →  word      gsc'"  →  'x' becomes "x"
  {
    "nvim-mini/mini.surround",
    keys = {
      { "gsa", mode = { "n", "x" }, desc = "Add surrounding" },
      { "gsd", desc = "Delete surrounding" },
      { "gsc", desc = "Change surrounding" },
      { "gsf", desc = "Find surrounding (right)" },
      { "gsF", desc = "Find surrounding (left)" },
      { "gsh", desc = "Highlight surrounding" },
    },
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        replace = "gsc",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        update_n_lines = "",
      },
    },
  },

  -- Better text objects: a/i for arguments (a), function calls (f), quotes (q),
  -- brackets (b), and "next/last" variants like cin" or dal).
  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    opts = { n_lines = 500 },
  },

  -- Auto-close brackets and quotes
  {
    "nvim-mini/mini.pairs",
    event = "InsertEnter",
    opts = {},
  },
}
