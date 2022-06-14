-- Lsp-Installer
local path = require('lspconfig.util').path
local lsp_installer = require('nvim-lsp-installer')

-- Apply settings
lsp_installer.setup({
  automatic_installation = false,
  install_root_dir = path.join({ vim.fn.stdpath('data'), 'servers' }),
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Set floating UI options for lsp-installer',
  group = vim.api.nvim_create_augroup('LspInstallerUI', {}),
  pattern = 'lsp-installer',
  callback = function()
    vim.api.nvim_win_set_config(0, { border = 'rounded' })
  end,
})
