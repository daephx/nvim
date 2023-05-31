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
      region_check_events = "InsertEnter",
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
    ls.filetype_extend("javascript", { "javascriptreact" })
    ls.filetype_extend("typescript", { "typescriptreact" })

    -- Load primary LSP snippets from friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    -- Add local LSP snippets from config runtime path
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/snippets/" },
    })
    -- Add local lua snippets from snippets module
    require("luasnip.loaders.from_lua").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/lua/snippets/" },
    })
  end,
}
