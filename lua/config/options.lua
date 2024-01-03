-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.clipboard = ""
opt.spelllang = {}

-- configuration for neovide
if vim.g.neovide then
  vim.o.guifont = "终端更纱黑体-简 Nerd:h12"
end
