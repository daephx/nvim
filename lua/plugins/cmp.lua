-- nvim-cmp | A completion plugin for neovim coded in Lua
-- https://github.com/hrsh7th/nvim-cmp
local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
  return
end

local kinds = require('plugins.lsp.icons').kinds

-- Detect whitespace before cursor position.
local check_backspace = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

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
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),

    ['<Down>'] = cmp.mapping({
      n = cmp.mapping.select_next_item(),
      c = cmp.mapping.select_prev_item(),
      i = cmp.config.disable,
    }),

    ['<Up>'] = cmp.mapping({
      n = cmp.mapping.select_prev_item(),
      c = cmp.mapping.select_next_item(),
      i = cmp.config.disable,
    }),

    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() and not check_backspace() then
        cmp.confirm({ select = true })
      elseif require('luasnip').expand_or_jumpable() then
        require('luasnip').expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if require('luasnip').jumpable(-1) then
        require('luasnip').jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    {
      name = 'buffer',
      max_item_count = 8,
      keyword_length = 4,
      option = {
        -- use only buffers from current tabpage, but omit man pages as they can
        -- slow down neovim by being too large
        get_bufnrs = function()
          local ret = {}
          for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local bufnr = vim.api.nvim_win_get_buf(winid)
            local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
            if ft ~= 'man' then
              table.insert(ret, bufnr)
            end
          end
          return ret
        end,
      },
    },
    {
      name = 'path',
      keyword_length = 10,
      max_item_count = 10,
    },
  }),
  experimental = {
    ghost_text = true, -- Let's play with this for a day or two
    native_menu = false, -- I like the new menu better! Nice work hrsh7th
  },
})
