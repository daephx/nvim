--     ____  __            _
--    / __ \/ /_  ______ _(_)___  _____
--   / /_/ / / / / / __ `/ / __ \/ ___/
--  / ____/ / /_/ / /_/ / / / / (__  )
-- /_/   /_/\__,_/\__, /_/_/ /_/____/
-- ==============/____/================
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
return packer.startup({function(use)

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

  use { -- Dashboard / Startscreen
    'glepnir/dashboard-nvim',
    config = function() require('plugins.dashboard') end
  }

  use { -- Buffer / Tab list for file navigation
    'romgrk/barbar.nvim',
    disable = true,
    config = function() require('plugins.barbar') end
  }

  use { -- Buffer / Tab list for file navigation
    'akinsho/bufferline.nvim',
    disable = false,
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function() require('plugins.bufferline') end
  }

  use { -- Blazing fast statusline
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function() require('plugins.lualine') end
  }

  use { -- Render blanklines
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufWinEnter' },
    config = function() require('plugins.indent-blankline') end
  }


  --- Utilities ---

  use { -- Highly extendable fuzzy finder
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      { -- FZF sorter for telescope written in c
        'nvim-telescope/telescope-fzf-native.nvim', run = 'make',
        disable = true
      },
    },
    config = function() require('plugins.telescope').config() end
  }

  use {'nvim-telescope/telescope-project.nvim'}

  use { -- FZF - Commandline fuzzy-finder
    'junegunn/fzf.vim',
    disable = true,
    requires = {'junegunn/fzf', dir = '~/.fzf', run = './install --all' },
    config = function() require('plugins.fzf') end
  }

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
  augroup plugins_au
    autocmd!
    autocmd BufWritePost lua/plugins.lua source <afile> | PackerCompile
  augroup END
  ]]

end,
  config = require('plugins.packer').config
})
