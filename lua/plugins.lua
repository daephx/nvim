--     ____  __            _
--    / __ \/ /_  ______ _(_)___  _____
--   / /_/ / / / / / __ `/ / __ \/ ___/
--  / ____/ / /_/ / /_/ / / / / (__  )
-- /_/   /_/\__,_/\__, /_/_/ /_/____/
--               /____/
-- Module: plugins
-- Description: plugins definitions and settings

local cmd = vim.cmd

-- Control vim builtin plugins
require('plugins.builtins')

local ok, packer = pcall(require, "packer")
if not ok then
  require("plugins.packer").bootstrap()
  packer = require('packer')
end


--- Plugins ---

-- Initalize packer/plugin list
return packer.startup(function(use)

  use { -- Packer can manage itself
    'wbthomason/packer.nvim',
  }

  -- ======================================
  -- * Place your plugin definitions here *
  -- ======================================

  --- Stylization ---

  use { -- Dark+ theme written in lua
    'Mofiqul/vscode.nvim',
    config = function() require('colors').setup('vscode') end
  }
  use { -- TokyoNight ColorScheme
    'folke/tokyonight.nvim',
    config = function() require('colors').setup('tokyonight') end
  }
  use {
    'numtostr/sakura.nvim',
    config = function() require('colors').setup('sakura') end
  }
  use {
    'morhetz/gruvbox',
    config = function() require('colors').setup('gruvbox') end
  }

  -- use 'shaunsingh/moonlight.nvim'
  -- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- use {"lukas-reineke/indent-blankline.nvim", branch = "lua"}
  -- use 'lewis6991/spellsitter.nvim'

  -- use 'mg979/vim-visual-multi'
  -- use 'phaazon/hop.nvim'
  -- use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}

  -- use 'hrsh7th/nvim-compe'
  -- use 'onsails/lspkind-nvim'
  -- use 'neovim/nvim-lspconfig'
  -- use 'folke/lsp-trouble.nvim'
  -- use 'glepnir/lspsaga.nvim'
  -- use 'kabouzeid/nvim-lspinstall'
  -- use 'ray-x/lsp_signature.nvim'

  -- use 'hrsh7th/vim-vsnip'
  -- use 'hrsh7th/vim-vsnip-integ'
  -- use 'rafamadriz/friendly-snippets'

  -- ======================================
  -- *       END OF PLUGIN SECTION       *
  -- ======================================

  --- Update/Sync ---
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if Packer_bootstrap then
    packer.sync()
  end

  --- Recompiler ---
  -- Recompile packer definitions when this file is modifed
  -- This allows your plugins and configurations to be kept fast

  cmd [[
  augroup packer_au
    autocmd!
    autocmd BufWritePost lua/plugins/init.lua source <afile> | PackerCompile
  augroup END
  ]]

end)
