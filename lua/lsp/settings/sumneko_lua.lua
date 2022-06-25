-- sumneko-lua language server

local M = {}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

M.setup = function(capabilities, on_attach)
  return {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = runtime_path,
        },
        diagnostics = {
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
          maxPreload = 2000,
          preloadFileSize = 50000,
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
end

return M
