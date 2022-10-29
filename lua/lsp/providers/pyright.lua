-- Pyright: Python Language-server configuration
-- For more information on setting up language-servers, See:
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md

local M = {}

local exepath = vim.fn.exepath
local path = require('lspconfig.util').path

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ '*', '.*' }) do
    local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
    if match ~= '' then
      return path.join(path.dirname(match), 'bin', 'python')
    end
  end

  -- Fallback to system Python.
  return exepath('python3') or exepath('python') or 'python'
end

-- use the VIRTUAL_ENV path if it exists else just use the system default
vim.g.python3_host_prog = get_python_path()

M.setup = function(capabilities, on_attach)
  return {
    capabilities = capabilities,
    on_attach = on_attach,
    -- cmd = { pyright_binary, '--stdio' },
    on_init = function(client)
      client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
    end,
    analysis = {
      -- search subdirectories like src; defaults to true
      autoSearchPaths = true,
      -- make completion a lot faster,
      -- especially when large libraries are imported; auto-import suffers though generally good
      -- improvement as completion is not cached like as opposed to vscode defaults to true
      useLibraryCodeForTypes = false,
    },
  }
end

return M
