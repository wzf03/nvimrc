return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function(_, opts)
      local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
      parser_configs["markdown"] = {
        install_info = {
          url = "https://github.com/wzf03/tree-sitter-markdown",
          location = "tree-sitter-markdown",
          files = { "src/parser.c", "src/scanner.c" },
        },
        maintainers = { "@MDeiml" },
        readme_name = "markdown (basic highlighting)",
        experimental = true,
      }

      parser_configs["markdown_inline"] = {
        install_info = {
          url = "https://github.com/wzf03/tree-sitter-markdown",
          location = "tree-sitter-markdown-inline",
          files = { "src/parser.c", "src/scanner.c" },
        },
        maintainers = { "@MDeiml" },
        readme_name = "markdown_inline (needed for full highlighting)",
        experimental = true,
      }
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
