return {
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function(_, _)
      local npairs = require("nvim-autopairs")
      npairs.setup({
        -- check_ts = true,
        -- ts_config = {
        --   markdown_inline = { "latex_block" },
        -- },
      })
    end,
  },
}
