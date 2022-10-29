-- nvim-autopairs | autopairs for neovim written by lua
-- https://github.com/windwp/nvim-autopairs
local autopairs_ok, autopairs = pcall(require, 'nvim-autopairs')
if not autopairs_ok then
  return
end

-- Initialize plugin settings
autopairs.setup({
  check_ts = true,
  disable_filetype = { 'TelescopePrompt', 'vim' },
  fast_wrap = {},
  ts_config = {
    lua = { 'string', 'source' },
    javascript = { 'string', 'template_string' },
  },
})

-- Enable cmp compatibility
local cmp_ok, cmp = pcall(require, 'cmp')
if cmp_ok then
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local handlers = require('nvim-autopairs.completion.handlers')
  -- Complete parens after select function or method item
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done({
      filetypes = {
        ['*'] = { -- "*" alias to all filetypes
          ['('] = {
            kind = {
              cmp.lsp.CompletionItemKind.Function,
              cmp.lsp.CompletionItemKind.Method,
            },
            handler = handlers['*'],
          },
        },
      },
    })
  )
end

--- Rules ---

local Rule = require('nvim-autopairs.rule')

-- Javascript arrow function
autopairs.add_rule(Rule('%(.*%)%s*%=>$', ' {}', {
  'javascript',
  'typescript',
  'typescriptreact',
}):use_regex(true):set_end_pair_length(1))
