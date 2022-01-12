-- lspconfig for sumneko-lua language server

local sumneko_binary
local sumneko_root = vim.fn.stdpath('data') .. '/lsp_servers/sumneko_lua/extension/server'
if vim.fn.has('mac') == 1 then
  sumneko_binary = sumneko_root .. '/bin/lua-language-server'
elseif vim.fn.has('unix') == 1 then
  sumneko_binary = sumneko_root .. '/bin/lua-language-server'
elseif vim.fn.has('win32') == 1 then
  sumneko_binary = sumneko_root .. '/bin/lua-language-server.exe'
else
  error('Unsupported system for sumneko_lua')
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local M = {}

M.setup = {
  cmd = { sumneko_binary, '-E', sumneko_root .. '/main.lua' },
  log_level = 2,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        enable = true,
        globals = {
          'after_each',
          'before_each',
          'describe',
          'it',
          'pending',
          'teardown',
          'vim',
        },
        disable = { 'lowercase-global' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
        maxPreload = 2000,
        preloadFileSize = 50000,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

return M
