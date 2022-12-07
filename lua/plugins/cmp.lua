-- nvim-cmp | A completion plugin for neovim coded in Lua
-- https://github.com/hrsh7th/nvim-cmp
local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
  return
end

local kinds = require('plugins.lsp.icons').kinds

cmp.setup({
  enable = true,
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format('%s %s', kinds[vim_item.kind], vim_item.kind)
      vim_item.max_width = 50
      vim_item.menu = ({
        buffer = '[Buffer]',
        cmp_tabnine = '[TabNine]',
        crates = '[Crates]',
        latex_symbols = '[Latex]',
        luasnip = '[LuaSnip]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[Lua]',
        path = '[Path]',
        spell = '[Spell]',
        ultisnips = '[Ultisnips]',
        vsnip = '[VSnip]',
        zsh = '[Shell]',
      })[entry.source.name]
      return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    -- HACK: This is attempt to make completion work similar to visual studio
    -- It has an issue where tab context is finicky, it will wait for timeoutlen
    -- before single tab or attmpet a completeion where it's not needed.
    -- It would be better if it checked for pummenu and if the cursor was before/after whitespace
    ['<Tab><Tab>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,

      -- copied from cmp-under, but I don't think I need the plugin for this.
      function(entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find('^_+')
        local _, entry2_under = entry2.completion_item.label:find('^_+')
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end,

      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'treesitter' },
    { name = 'luasnip' }, -- For luasnip users.
    {
      name = 'buffer',
      keyword_length = 4,
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    { name = 'calc' },
    { name = 'emoji' },
    { name = 'spell' },
    { name = 'path' },
    { name = 'gh_issues' },
  },
  experimental = {
    ghost_text = true, -- Let's play with this for a day or two
    native_menu = false, -- I like the new menu better! Nice work hrsh7th
  },
})
