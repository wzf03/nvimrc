return {
  {
    "hrsh7th/cmp-path",
    enabled = false,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "FelipeLema/cmp-async-path", "wzf03/cmp-latex-symbols" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "async_path" },
        { name = "latex_symbols", option = {
          strategy = 2,
          ft = { "markdown" },
        } },
      }))
      -- local config = require("cmp.config")

      -- local markdown_config = vim.tbl_extend("force", config.filetypes["markdown"] or {}, {
      --   sources = {
      --     {
      --       name = "latex_symbols",
      --       option = {
      --         strategy = 2,
      --       },
      --     },
      --   },
      -- })
      -- cmp.setup.filetype({ "markdown" }, markdown_config)
    end,
  },
}
