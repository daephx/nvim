local site_dir = string.format('%s/site', vim.fn.stdpath('data'))
local packer_dir = string.format('%s/pack/packer', site_dir)
local packer_compiled = string.format('%s/lua/packer_compiled.lua', site_dir)

local M = {}

-- Ensure packer is available for fresh installation.
-- Return true/false if packer is properly installed.
---@return boolean
M.ensure_packer = function()
  local fn = vim.fn
  local install_path = string.format('%s/start/packer.nvim', packer_dir)
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
    })
    vim.cmd([[packadd packer.nvim]])
    return true
  end

  return false
end

-- Generate plugin config string for packer compile
---@param name string
---@return string
M.config = function(name)
  local str = string.format('require("%s")', name)
  local module_ok, module = pcall(require, name)
  if module_ok then
    if type(module) == 'table' then
      if type(module['setup']) == 'function' then
        str = string.format('%s.setup({})', str)
      end
    end
  else
    str = string.format('%s.setup({})', str)
  end

  return str
end

-- Return packer.setup options
---@return table
M.setup = function()
  return {
    compile_path = packer_compiled,
    disable_commands = false,
    display = {
      prompt_border = 'single',
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end,
    },
    git = { clone_timeout = 120 },
  }
end

return M
