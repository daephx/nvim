-- LuaSnip | Snippet Engine for Neovim written in Lua.
-- https://github.com/L3MON4D3/LuaSnip
local ls_ok, ls = pcall(require, 'luasnip')
if not ls_ok then
  return
end

local types = require('luasnip.util.types')

--- Settings ---

ls.config.set_config({
  history = true,
  ext_prio_increase = 1,
  enable_autosnippets = true,
  store_selection_keys = '<Tab>',
  updateevents = 'TextChanged,TextChangedI',
  delete_check_events = 'TextChanged,InsertLeave',
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { '●', 'Comment' } },
      },
    },
  },
})

-- Extend snippet language
-- Compatibility with `honza/vim-snippets`: all = '_'
ls.filetype_extend('all', { '_' })
ls.filetype_extend('glsl', { 'c' })

-- Add local snippet directories to runtime path
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_vscode').lazy_load({
  paths = { vim.fn.stdpath('config') .. '/snippets/' },
})
require('luasnip.loaders.from_lua').lazy_load({
  paths = { vim.fn.stdpath('config') .. '/lua/snippets/' },
})
