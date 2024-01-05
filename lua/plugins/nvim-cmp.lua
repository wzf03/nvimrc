return {
  {
    "hrsh7th/cmp-path",
    enabled = false,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "FelipeLema/cmp-async-path",
      "wzf03/cmp-latex-symbols",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.sources = cmp.config.sources({
        { name = "async_path" },
        {
          name = "latex_symbols",
          option = {
            strategy = 2,
            ft = { "markdown" },
          },
        },
        {
          name = "nvim_lsp",
          entry_filter = function(entry)
            return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
          end,
        },
        { name = "luasnip" },
      })
    end,
  },
}
