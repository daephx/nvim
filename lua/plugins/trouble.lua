-- trouble.nvim | pretty diagnostics, references, telescope results
-- https://github.com/folke/trouble.nvim
local trouble_ok, trouble = pcall(require, 'trouble')
if not trouble_ok then
  return
end

trouble.setup({
  padding = false, -- add an extra new line on top of the list
  auto_open = false, -- automatically open the list when you have diagnostics
  auto_close = true, -- automatically close the list when you have no diagnostics
  use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
})

local telescope_ok, telescope = pcall(require, 'telescope')
if telescope_ok then
  -- local actions = require('telescope.actions')
  local _trouble = require('trouble.providers.telescope')
  telescope.setup({
    defaults = {
      mappings = {
        i = { ['<c-t>'] = _trouble.open_with_trouble },
        n = { ['<c-t>'] = _trouble.open_with_trouble },
      },
    },
  })
end

--- Autocmds ---

vim.api.nvim_create_augroup('TroubleBuffer', {})
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Apply local options to Trouble buffer ',
  group = 'TroubleBuffer',
  pattern = 'Trouble',
  callback = function()
    vim.opt_local.cursorline = true
    vim.opt_local.cursorlineopt = 'both'
    vim.opt_local.colorcolumn = '0'
  end,
})
