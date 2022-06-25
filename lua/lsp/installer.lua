-- Lsp-Installer
local lsp_installer_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not lsp_installer_ok then
  local msg = table.concat({ 'nvim-lsp-installer failed to initialize' }, '\n')
  vim.notify(msg, vim.lsp.log_levels.ERROR, { title = 'Plugin Error' })
  return
end

local path = require('lspconfig.util').path

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
