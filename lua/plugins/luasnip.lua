return {
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
    config = function(_, opts)
      local ls = require("luasnip")
      local types = require("luasnip.util.types")
      ls.setup(opts)
      ls.config.setup({
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "●", "GruvboxOrange" } },
            },
          },
          [types.insertNode] = {
            active = {
              virt_text = { { "●", "GruvboxBlue" } },
            },
          },
        },
        enable_autosnippets = true,
      })
    end,
  },
}
