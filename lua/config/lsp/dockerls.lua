local dockerls_binary
local dockerls_root = vim.fn.stdpath('data')
  .. '/dockerfile/node_modules/dockerfile-language-server-nodejs'
if vim.fn.has('mac') == 1 then
  dockerls_binary = dockerls_root .. '/bin/docker-langserver'
elseif vim.fn.has('unix') == 1 then
  dockerls_binary = dockerls_root .. '/bin/docker-langserver'
elseif vim.fn.has('win32') == 1 then
  dockerls_binary = dockerls_root .. '/bin/docker-langserver.exe'
else
  error('Unsupported system for dockerls_lua')
end

local M = {}

M.setup = {
  cmd = { dockerls_binary, '--stdio' },
}

return M
