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

M.imgclip = {
  plugin = true,
  n = {
    ["<leader>ip"] = { "<cmd>PasteImage<cr>", "Paste clipboard image" },
  },
}

M.markdownpreview = {
  plugin = true,
  n = {
    ["<leader>mp"] = { "<cmd>MarkdownPreview<cr>", "Markdown Preview" },
  },
}

return M
