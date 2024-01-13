local M = {}

M.clipboard = {
  n = {
    ["<leader>p"] = { '"+p', "Paste from System Clipboard" },
    ["<leader>P"] = { '"+P', "Paste from System Clipboard" },
  },
  v = {
    ["<leader>y"] = { '"+y', "Yank to System Clipboard" },
  },
}

return M
