-- lua/config/keymaps.lua
-- Core, plugin-independent mappings. Plugin mappings live in each plugin spec.
--
-- Scheme: every <leader> key is a group named by a noun (labels in plugins/ui.lua).
--   f find · s splits · b buffers · g git · c code · o outline · k kubernetes
--   x diagnostics/lists · u ui toggles · p plugins · q quit · w write · e explorer
-- [x / ]x is always previous / next. Native LSP defaults (grn, gra, grr, gri, gO, K) are kept.

local map = vim.keymap.set

-- ── Essentials ─────────────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("x", "<", "<gv", { desc = "Indent left" })
map("x", ">", ">gv", { desc = "Indent right" })
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Write file" })
map("n", "<leader>qq", "<cmd>qall<cr>", { desc = "Quit all" })

-- ── Splits (<leader>s) ─────────────────────────────────────────────────
-- Moving between splits is Ctrl-h/j/k/l (shared with tmux, see plugins/tmux.lua).
map("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
map("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
map("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close split" })
map("n", "<leader>so", "<cmd>only<cr>", { desc = "Only this split" })

-- ── Buffers (<leader>b) ────────────────────────────────────────────────
-- Cycling is native: [b / ]b
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>bo", function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.bo[buf].buflisted and not vim.bo[buf].modified then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end, { desc = "Delete other buffers" })

-- ── Lists (<leader>x) ──────────────────────────────────────────────────
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix list" })
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location list" })

-- ── UI toggles (<leader>u) ─────────────────────────────────────────────
local function toggle(option)
  return function()
    vim.opt_local[option] = not vim.opt_local[option]:get()
    vim.notify(option .. ": " .. tostring(vim.opt_local[option]:get()))
  end
end
map("n", "<leader>uw", toggle("wrap"), { desc = "Toggle wrap" })
map("n", "<leader>un", toggle("relativenumber"), { desc = "Toggle relative numbers" })
map("n", "<leader>us", toggle("spell"), { desc = "Toggle spell" })
map("n", "<leader>ud", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })
map("n", "<leader>uh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })

-- ── Plugins (<leader>p) ────────────────────────────────────────────────
map("n", "<leader>pl", "<cmd>Lazy<cr>", { desc = "Lazy" })
