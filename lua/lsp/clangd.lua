local clangd_binary
local clangd_root_path = vim.fn.stdpath('data') .. '/lsp_servers/clangd/clangd_13.0.0'
if vim.fn.has('mac') == 1 then
  clangd_binary = clangd_root_path .. '/bin/clangd'
elseif vim.fn.has('unix') == 1 then
  clangd_binary = clangd_root_path .. '/bin/clangd'
elseif vim.fn.has('win32') == 1 then
  clangd_binary = clangd_root_path .. '/bin/clangd'
else
  error('Unsupported system for clangd')
end

local M = {}

M.setup = {
  cmd = {
    clangd_binary,
    '--background-index',
    -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
    -- to add more checks, create .clang-tidy file in the root directory
    -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
    '--clang-tidy',
    '--fallback-style=llvm',
    '--completion-style=bundled',
    '--cross-file-rename',
    '--header-insertion=iwyu',
  },
  init_options = {
    clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
}

return M
