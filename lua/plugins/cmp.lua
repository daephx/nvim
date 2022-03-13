-- nvim-cmp setup
local cmp = require('cmp')
local lspkind = require('lspkind')

lspkind.init({
  symbol_map = {
    Class = 'ﴯ',
    Color = '',
    Constant = '',
    Constructor = '',
    Enum = '',
    EnumMember = '',
    Event = '',
    Field = 'ﰠ',
    File = '',
    Folder = '',
    Function = '',
    Interface = '',
    Keyword = '',
    Method = '',
    Module = '',
    Operator = '',
    Property = 'ﰠ',
    Reference = '',
    Snippet = '',
    Struct = 'פּ',
    Text = '',
    TypeParameter = '',
    Unit = '塞',
    Value = '',
    Variable = '',
  },
})

cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  experimental = {
    native_menu = false, -- I like the new menu better! Nice work hrsh7th
    ghost_text = true, -- Let's play with this for a day or two
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
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    {
      name = 'buffer',
      -- keyword_length = 4,
      options = {
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
  formatting = {
    --   with_text = false,
    format = function(entry, vim_item)
      vim_item.kind = string.format('%s %s', lspkind.presets.default[vim_item.kind], vim_item.kind)
      -- vim_item.with_text = false
      vim_item.max_width = 50
      vim_item.menu = ({
        nvim_lsp = 'ﲳ',
        nvim_lua = '',
        treesitter = '',
        path = 'ﱮ',
        buffer = '﬘',
        zsh = '',
        vsnip = '',
        luasnip = '',
        spell = '暈',
      })[entry.source.name]
      return vim_item
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),

    ['<C-Space>'] = cmp.mapping.complete(),

    -- HACK: This is attempt to make completion work similar to visual studio
    -- It has an issue where tab context is finicky, it will wait for timeoutlen
    -- before single tab or attmpet a completeion where it's not needed.
    -- It would be better if it checked for pummenu and if the cursor was before/after whitespace
    ['<Tab><Tab>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),

    -- Right is for ghost_text to behave like terminal
    -- NOTE: Cool! but I only want it to confirm if the completion menu has an active selection.
    -- ["<Right>"] = cmp.mapping.confirm { select = true },

    -- Insert instead of Select so you don't go away at `stopinsert` after `CursorHoldI`
    -- @TODOUA: I want to be able to `Select` without `stopinsert` killing it (& keep `stopinsert`)
    -- ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }, { "i", "c" }),
    -- ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }, { "i", "c" }),
    -- ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }, { "i", "c" }),
    -- ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }, { "i", "c" }),

    -- Alternative :h ins-completion
    -- ['<Tab>'] = function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   else
    --     fallback()
    --   end
    -- end,
    --
    -- ['<S-Tab>'] = function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   else
    --     fallback()
    --   end
    -- end,
  },
})

-- @dmitmel | https://github.com/dmitmel/cmp-cmdline-history
-- this will also setup the history completion for all command-line modes
-- This at the moment doesn't fully work in the same way that vim's cmd history list
-- is displayed and causes some friction in my workflow. It will be disabled for now.
-- for _, cmd_type in ipairs({':', '/', '?', '@', '='}) do
--   cmp.setup.cmdline(cmd_type, {
--     sources = {
--       { name = 'cmdline_history', keyword_length = 4 },
--     },
--   })
-- end
