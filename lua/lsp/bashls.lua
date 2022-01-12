-- File: bash-lsp.lua
-- Description: Language-server configuration
--
-- Language-server binaries are required for this to work
-- Some are easily to install than others.
--
-- For more information on setting up language-servers, See:
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md

local M = {}

M.setup = {
  filetypes = { 'sh', 'zsh', 'bash' },
}

return M
