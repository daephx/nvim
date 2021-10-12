--- Plugins

local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end

-- Load Plugins
require('packer').startup(function()

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
end)
