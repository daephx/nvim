--     ____  __            _
--    / __ \/ /_  ______ _(_)___  _____
--   / /_/ / / / / / __ `/ / __ \/ ___/
--  / ____/ / /_/ / /_/ / / / / (__  )
-- /_/   /_/\__,_/\__, /_/_/ /_/____/
--               /____/
-- Module: plugins
-- Description: plugins definitions and settings

local cmd = vim.cmd
local fn = vim.fn

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

  -- use "wbthomason/packer.nvim"
  -- use {'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}}
  -- use 'romgrk/barbar.nvim'
  -- use 'kyazdani42/nvim-tree.lua'
  -- use 'glepnir/dashboard-nvim'

  -- use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  -- use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim'}

  -- use 'kdav5758/TrueZen.nvim'
  -- use 'junegunn/limelight.vim'
  -- use 'yamatsum/nvim-cursorline'
  -- use 'norcalli/nvim-colorizer.lua'

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
