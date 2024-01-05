return {
  {
    "wzf03/luasnip-latex-snippets.nvim",
    ft = { "tex", "markdown" },
    -- vimtex isn't required if using treesitter
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    opts = {
      use_treesitter = true,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "latex",
      })
    end,
  },
}
