local opt = vim.opt

opt.clipboard = ""
opt.spelllang = {}

-- solve problems on Redmibook Pro 15
vim.api.nvim_set_keymap("", "<kEnter>", "<Enter>", {})
vim.api.nvim_set_keymap("i", "<kEnter>", "<Enter>", {})
vim.api.nvim_set_keymap("c", "<kEnter>", "<Enter>", {})

-- quit nvcheatsheet with q
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("cheatsheet_quit_with_q", { clear = true }),
  pattern = {
    "nvcheatsheet",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>NvCheatsheet<cr>", { buffer = event.buf, silent = true })
  end,
})
