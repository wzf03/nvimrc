local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "markdown",
        "markdown_inline",
        "latex",
        "c",
        "cpp",
        "rust",
        "python",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      -- format & linting
      {
        "nvimtools/none-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
      {
        "williamboman/mason.nvim",
        config = function(_, opts)
          dofile(vim.g.base46_cache .. "mason")
          opts.ensure_installed = {
            "prettier",
            "stylua",
            "clang-format",
          }
          require("mason").setup(opts)
          vim.api.nvim_create_user_command("MasonInstallAll", function()
            vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
          end, {})
          require "custom.configs.lspconfig" -- Load in lsp config
        end,
      },
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
    },
    config = function() end, -- Override to setup mason-lspconfig
  },

  -- markdown
  {
    "wzf03/luasnip-latex-snippets.nvim",
    ft = { "markdown", "tex" },
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    opts = {
      use_treesitter = true,
    },
    config = function(_, opts)
      require("luasnip").config.setup { enable_autosnippets = true }
      require("luasnip-latex-snippets").setup(opts)
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      {
        "<leader>mp",
        "<cmd>MarkdownPreview<cr>",
        desc = "Markdown Preview",
      },
    },
  },

  {
    "wzf03/img-clip.nvim",
    event = "BufEnter",
    opts = {},
    keys = {
      { "<leader>ip", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
    },
  },
}

return plugins