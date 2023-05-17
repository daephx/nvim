-- LuaSnip | Snippet Engine for Neovim written in Lua.
-- https://github.com/L3MON4D3/LuaSnip

return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  dependencies = {
    -- Set of preconfigured snippets for different languages.
    "rafamadriz/friendly-snippets",
  },
  opts = function()
    local types = require("luasnip.util.types")
    return {
      history = true,
      ext_prio_increase = 1,
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
      updateevents = "TextChanged,TextChangedI",
      delete_check_events = "TextChanged,InsertLeave",
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "●", "Comment" } },
          },
        },
      },
    }
  end,
  config = function(_, opts)
    local ls = require("luasnip")
    ls.config.set_config(opts)

    -- Extend snippet language
    -- Compatibility with `honza/vim-snippets`: all = '_'
    ls.filetype_extend("all", { "_" })
    ls.filetype_extend("glsl", { "c" })

    -- Add local snippet directories to runtime path
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/snippets/" },
    })
    require("luasnip.loaders.from_lua").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/lua/snippets/" },
    })
  end,
}
