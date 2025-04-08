-- BETA 
--  TO use this put this in your plugins table
-- { import = "nvchad.blink.lazyspec" },

return {
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
  },

  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "nvchad.configs.luasnip"
        end,
      },
    },

    opts_extend = { "sources.default" },

    opts = function()
      return require "nvchad.blink.config"
    end,
  },
}
