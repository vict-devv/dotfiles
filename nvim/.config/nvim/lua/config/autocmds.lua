-- lua/config/autocmds.lua
local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end
local autocmd = vim.api.nvim_create_autocmd

-- Briefly highlight yanked text
autocmd("TextYankPost", {
  group = augroup("yank_highlight"),
  callback = function() vim.hl.on_yank({ timeout = 150 }) end,
})

-- Reload files changed outside Neovim (git checkout, kubectl edit, terraform fmt…)
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then vim.cmd.checktime() end
  end,
})

-- Return to the last cursor position when reopening a file
autocmd("BufReadPost", {
  group = augroup("last_position"),
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    local lines = vim.api.nvim_buf_line_count(ev.buf)
    if mark[1] > 0 and mark[1] <= lines and vim.bo[ev.buf].filetype ~= "gitcommit" then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Keep splits balanced when the terminal or tmux pane is resized
autocmd("VimResized", {
  group = augroup("resize_splits"),
  callback = function() vim.cmd("tabdo wincmd =") end,
})

-- Close throwaway windows with q
autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = { "help", "qf", "man", "checkhealth", "lspinfo", "git" },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true, desc = "Close window" })
  end,
})

-- Prose files: soft wrap and spell checking
autocmd("FileType", {
  group = augroup("prose"),
  pattern = { "markdown", "gitcommit", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
})
