return {
  {
    "hrsh7th/cmp-path",
    enabled = false,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "FelipeLema/cmp-async-path", "kdheepak/cmp-latex-symbols" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "async_path" },
      }))
      cmp.setup.filetype({ "markdown" }, {
        sources = {
          {
            name = "latex_symbols",
            option = {
              strategy = 2,
            },
          },
        },
      })
    end,
  },
}
