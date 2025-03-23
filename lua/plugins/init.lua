return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "markdown", "fish"
      },
    },
  },

  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    keys = {
      { "<leader>tv", "<cmd>VimtexView<cr>",    desc = "Vimtex Preview" },
      { "<leader>tc", "<cmd>VimtexCompile<cr>", desc = "Vimtex Compile" }
    },
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_syntax_enabled = 1
      vim.o.conceallevel = 2
    end
  },

  {
    "L3MON4D3/LuaSnip",
    opts = {
      enable_autosnippets = true,
      store_selection_keys = "<Tab>"
    },
    build = "make install_jsregexp",
  },

  {
    "lervag/vimtex",
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local cmp = require("cmp")
      local conf = require("nvchad.configs.cmp")

      local mymappings = {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if require("luasnip").expand_or_jumpable() then
            require("luasnip").expand_or_jump()
          elseif cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if require("luasnip").jumpable(-1) then
            require("luasnip").jump(-1)
          elseif cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" })
      }
      conf.mapping = vim.tbl_deep_extend("force", conf.mapping, mymappings)
      return conf
    end,
  },
  {
    "windwp/nvim-autopairs",
    opts = {
      disable_filetype = { "TelescopePrompt", "vim", "tex" },
    },
  }
}
