local M = {}

-- Ensure packer is available for fresh installation
M.ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
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
    compile_path = require('packer.util').join_paths(fn.stdpath('config'), 'plugin', 'packer_compiled.lua'),
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
