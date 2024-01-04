return {
  {
    "antonk52/markdowny.nvim",
    ft = {
      "markdown",
    },
    keys = {
      { "<C-b>", ":lua require('markdowny').bold()<cr>", mode = "v", desc = "markdowny.nvim keymaps" },
      { "<C-i>", ":lua require('markdowny').italic()<cr>", mode = "v", desc = "markdowny.nvim keymaps" },
    },
  },
}
