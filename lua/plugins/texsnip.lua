return {
  {
    "wzf03/luasnip-latex-snippets.nvim",
    ft = { "tex", "markdown" },
    -- vimtex isn't required if using treesitter
    dependencies = {
      "L3MON4D3/LuaSnip",
      config = function()
        require("luasnip").config.setup({ enable_autosnippets = true })
      end,
    },
    opts = {
      use_treesitter = true,
    },
  },
}
