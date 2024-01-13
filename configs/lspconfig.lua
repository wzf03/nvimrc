local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

require("neodev").setup({})

local lspconfig = require "lspconfig"

-- List of servers to install
local servers = { "clangd", "rust_analyzer", "marksman" }

require("mason-lspconfig").setup {
  ensure_installed = servers,
  automatic_installation = true,
}

-- This will setup lsp for servers you listed above
-- And servers you install through mason UI
-- So defining servers in the list above is optional
require("mason-lspconfig").setup_handlers {
  -- Default setup for all servers, unless a custom one is defined below
  function(server_name)
    lspconfig[server_name].setup {
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        -- Add your other things here
        -- Example being format on save or something
      end,
      capabilities = capabilities,
    }
  end,
  -- custom setup for a server goes after the function above
  -- Example, override lua_ls
  ["lua_ls"] = function()
    lspconfig["lua_ls"].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    }
  end,
}
