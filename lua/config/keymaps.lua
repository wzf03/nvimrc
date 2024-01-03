-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- solve problems on Redmibook Pro 15
map("", "<kEnter>", "<Enter>", {})

-- yank and paste from system clipboard
map("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>p", '"+p"', { desc = "Paste from system clipboard" })
map("n", "<leader>P", '"+P"', { desc = "Paste from system clipboard" })
