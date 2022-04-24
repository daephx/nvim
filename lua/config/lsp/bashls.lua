-- File: bash-lsp.lua
-- Description: Language-server configuration
--
-- Language-server binaries are required for this to work
-- Some are easily to install than others.
--
-- For more information on setting up language-servers, See:
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md

local bashls_bin
local bashls_root = vim.fn.stdpath('data') .. '/lsp_servers/bash'
if vim.fn.has('mac') == 1 then
  bashls_bin = bashls_root .. '/node_modules/.bin/bash-language-server'
elseif vim.fn.has('unix') == 1 then
  bashls_bin = bashls_root .. '/node_modules/.bin/bash-language-server'
elseif vim.fn.has('win32') == 1 then
  bashls_bin = bashls_root .. '/node_modules/.bin/bash-language-server.exe'
else
  error('Unsupported system for bashls')
end

local M = {}

M.setup = {
  cmd = { bashls_bin, 'start' },
  filetypes = { 'sh', 'bash', 'zsh' },
}

return M
