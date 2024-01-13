local opt = vim.opt

opt.clipboard = ""
opt.spelllang = {}

-- solve problems on Redmibook Pro 15
vim.api.nvim_set_keymap("", "<kEnter>", "<Enter>", {})
vim.api.nvim_set_keymap("i", "<kEnter>", "<Enter>", {})
vim.api.nvim_set_keymap("c", "<kEnter>", "<Enter>", {})
