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

  --[[ use { -- Buffer / Tab list for file navigation
    'romgrk/barbar.nvim',
    disable = true,
    config = function() require('plugins.barbar') end
  } ]]

  --[[ use { -- Buffer / Tab list for file navigation
    'akinsho/bufferline.nvim',
    disable = true,
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function() require('plugins.bufferline') end
  } ]]

  use {
    'kdheepak/tabline.nvim',
    requires = {
      { 'hoob3rt/lualine.nvim', opt = true },
    },
    config = function() require('plugins.tabline') end
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

  use { -- FZF - Commandline fuzzy-finder
    'junegunn/fzf.vim',
    disable = true,
    requires = {'junegunn/fzf', dir = '~/.fzf', run = './install --all' },
    config = function() require('plugins.fzf') end
  }

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

  use { -- superior project management for neovim.
    "ahmedkhalf/project.nvim",
    config = function() require("plugins.project") end
  }

  -- use { -- A simple wrapper around :mksession
  --   "Shatur/neovim-session-manager",
  --   requires = { 'nvim-telescope/telescope.nvim' },
  --   config = function() require("plugins.session-manager") end
  -- }

  use { -- A small automated session manager for neovim
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        log_level = 'info',
        auto_session_enable_last_session = false,
        -- auto_restore_enabled = false,
        auto_session_suppress_dirs = {'~/', '~/Projects'}
      }
    end
  }

  use { -- A session-switcher extension for rmagatti/auto-session using Telescope.nvim
    'rmagatti/session-lens',
    requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
    config = function()
      require('session-lens').setup({
        path_display = {'shorten'},
        theme_conf = { border = true },
        previewer = false
      })
    end
  }

  use { -- Lua implimentation of vim-which-key
    'folke/which-key.nvim',
    config = function() require('plugins.whichkey') end
  }


  -- Git integrations

  use { -- A Git wrapper so awesome, it should be illegal
    'tpope/vim-fugitive',
    disable = false
  }

  use { -- Magit for Neovim
    'TimUntersberger/neogit',
    disable = false,
    requires = {
      'nvim-lua/plenary.nvim',
      {
        'sindrets/diffview.nvim',
        config = function() require('plugins.diffview') end
      }
    },
    config = function() require('plugins.neogit') end
  }

  use { -- Git signs written in pure lua
    'lewis6991/gitsigns.nvim',
    -- tag = 'release', -- To use the latest release
    event = { 'BufWinEnter', 'BufNewFile' },
    requires = {'nvim-lua/plenary.nvim'},
    config = function() require('plugins.gitsigns') end
  }


  -- Language Tools

  use {
    'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
    config = function() require('plugins.treesitter') end
  }
  use {'p00f/nvim-ts-rainbow', after = 'nvim-treesitter'}

  use { -- load extensions like VSCode and host language servers
    'neoclide/coc.nvim', branch = 'release',
    disable = true,
  }

  use { -- Native language server protocol
    'williamboman/nvim-lsp-installer',
    requires = {
      'neovim/nvim-lspconfig',
      'hrsh7th/nvim-cmp'
    },
    config = function() require('lsp') end
  }

  use { -- Debug adapter protocol client
    'mfussenegger/nvim-dap',
    requires = {{'rcarriga/nvim-dap-ui', opt = true}, {'nvim-dap-python', opt = true}},
    config = function() require('plugins.dap').load_modules() end
  }

  use {
    'nvim-telescope/telescope-dap.nvim',
    after = { 'telescope.nvim', 'nvim-dap' },
    config = function() require('telescope').load_extension('dap') end
  }


  -- Completion

  use {'L3MON4D3/LuaSnip'}
  use {'onsails/lspkind-nvim'}
  use {
    'hrsh7th/nvim-cmp',
    disable = false,
    -- event = { 'InsertEnter' },
    config = function() require('plugins.cmp') end,
    requires = {
      "f3fora/cmp-spell",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      'dmitmel/cmp-cmdline-history',
      'hrsh7th/cmp-nvim-lua',
      'onsails/lspkind-nvim',
      'saadparwaiz1/cmp_luasnip',
    },
  }

  use { -- Alternative FileTree
    'kyazdani42/nvim-tree.lua',
    requires = {'kyazdani42/nvim-web-devicons', opts = true},
    config = function() require('plugins.nvimtree') end
  }

  use { -- easily manage multiple terminal windows
    "akinsho/toggleterm.nvim",
    config = function() require('plugins.toggleterm') end
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('plugins.autopairs')
    end
  }

  use {
    'b3nj5m1n/kommentary',
    config = function()
      require('plugins.kommentary')
    end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require'colorizer'.setup({
      '*'; -- Highlight all files, you can still customize others!
      -- '!vim'; -- Exclude vim from highlighting.
      css = { mode = 'background'; };
      html = { mode = 'background'; };
      packer = { RGB = false; }
    }, { mode = 'foreground'; }) end
  }

  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function() require("plugins.todo-comments") end
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
