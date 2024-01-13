local M = {}

M.disabled = vim.tbl_deep_extend("force", {}, require("core.mappings").nvterm)

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

local lazygit = nil

M.toggleterm = {
  plugin = true,
  n = {
    ["<C-p>"] = { "<cmd>ToggleTerm<cr>", "Toggle Term" },
    ["<leader>tf"] = { "<cmd>ToggleTerm<cr>", "Toggle Term" },
    ["<leader>gg"] = {
      function()
        if lazygit == nil then
          local Terminal = require("toggleterm.terminal").Terminal
          lazygit = Terminal:new { cmd = "lazygit", hidden = true }
        end
        lazygit:toggle()
      end,
      "Toggle Lazygit",
    },
  },
}

return M
