--     ____  __            _
--    / __ \/ /_  ______ _(_)___  _____
--   / /_/ / / / / / __ `/ / __ \/ ___/
--  / ____/ / /_/ / /_/ / / / / (__  )
-- /_/   /_/\__,_/\__, /_/_/ /_/____/
-- ==============/____/================
-- Module: plugins
-- Description: plugins definitions and settings

-- Control vim builtin plugins
require('plugins.builtins')

-- Initalize packer plugin
local ok, packer = pcall(require, 'packer')
if not ok then
  require('plugins.packer').bootstrap()
  packer = require('packer')
end

--- Plugins ---

-- Initalize plugin list
return packer.startup({function(use)

    use({ -- Packer can manage itself
      'wbthomason/packer.nvim',
    })

    -- ======================================
    -- * Place your plugin definitions here *
    -- ======================================

    --- Stylization ---

    use({ -- Dark+ theme written in lua
      'Mofiqul/vscode.nvim',
      config = function()
        require('colors').setup('vscode')
      end,
    })

    use({ -- TokyoNight ColorScheme
      'folke/tokyonight.nvim',
      config = function()
        require('colors').setup('tokyonight')
      end,
    })

    use({ -- Nice pink neovim color scheme
      'numtostr/sakura.nvim',
      config = function()
        require('colors').setup('sakura')
      end,
    })

    use({ -- Retro groove color scheme for Vim
      'morhetz/gruvbox',
      config = function()
        require('colors').setup('gruvbox')
      end,
    })

    use({ -- Dashboard / Startscreen
      'glepnir/dashboard-nvim',
      config = function()
        require('plugins.dashboard')
      end,
    })

    use({ -- A "buffer and tab" tabline for neovim
      'kdheepak/tabline.nvim',
      requires = { 'nvim-lualine/lualine.nvim', opt = true },
      config = function()
        require('plugins.tabline')
      end,
    })

    use({ -- Blazing fast statusline
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require('plugins.lualine')
      end,
    })

    use({ -- Render blanklines
      'lukas-reineke/indent-blankline.nvim',
      event = { 'BufWinEnter' },
      config = function()
        require('plugins.indent-blankline')
      end,
    })


    --- Utilities ---

    use({ -- FZF - Commandline fuzzy-finder
      'junegunn/fzf.vim',
      disable = true,
      requires = { 'junegunn/fzf', dir = '~/.fzf', run = './install --all' },
      config = function()
        require('plugins.fzf')
      end,
    })

    use({ -- superior project management for neovim.
      'ahmedkhalf/project.nvim',
      config = function()
        require('plugins.project')
      end,
    })

    use({ -- Highly extendable fuzzy finder
      'nvim-telescope/telescope.nvim',
      requires = {
        { 'nvim-lua/popup.nvim' },
        { 'nvim-lua/plenary.nvim' },
        { -- FZF sorter for telescope written in c
          'nvim-telescope/telescope-fzf-native.nvim',
          run = 'make',
          disable = true,
        },
      },
      config = function()
        require('plugins.telescope').config()
      end,
    })

    use({ -- A small automated session manager for neovim
      'rmagatti/auto-session',
      config = function()
        require('auto-session').setup({
          log_level = 'info',
          auto_session_enable_last_session = false,
          -- auto_restore_enabled = false,
          auto_session_suppress_dirs = { '~/', '~/Projects' },
        })
      end,
    })

    use({ -- A session-switcher extension for rmagatti/auto-session using Telescope.nvim
      'rmagatti/session-lens',
      requires = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
      config = function()
        require('session-lens').setup({
          path_display = { 'shorten' },
          theme_conf = { border = true },
          previewer = false,
        })
      end,
    })

    use({ -- Lua implimentation of vim-which-key
      'folke/which-key.nvim',
      config = function()
        require('plugins.whichkey')
      end,
    })


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


  -- Language Utilities

  use { -- Advnaced language parsing for neovim
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
    config = function() require('plugins.dap').config() end
  }

  use { -- Debugging interface for nvim-dap
    "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"},
    config = function() require("dapui").setup({
      mappings = {
        expand = { "<CR>", "<2-LeftMouse>", "<Tab>" },
      },
      sidebar = {position = 'right'}
    }) end
  }

  use { -- Integration for nvim-dap with telescope.nvim
    'nvim-telescope/telescope-dap.nvim',
    after = { 'telescope.nvim', 'nvim-dap' },
  }


  -- Completion

  use { -- Snippet Engine for Neovim
    'L3MON4D3/LuaSnip'
  }

  use { -- vscode-like pictograms for neovim
    'onsails/lspkind-nvim'
  }

  use { -- A completion plugin for neovim
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

  use { -- Alternative File Tree
    'kyazdani42/nvim-tree.lua',
    requires = {'kyazdani42/nvim-web-devicons', opts = true},
    config = function() require('plugins.nvimtree') end
  }

  use { -- easily manage multiple terminal windows
    "akinsho/toggleterm.nvim",
    config = function() require('plugins.toggleterm') end
  }

  use { -- autopairs for neovim written in lua
    'windwp/nvim-autopairs',
    config = function()
      require('plugins.autopairs')
    end
  }

  use { -- Neovim commenting plugin, written in lua
    'b3nj5m1n/kommentary',
    config = function()
      require('plugins.kommentary')
    end
  }

  use { -- A high-performance color highlighter
    'norcalli/nvim-colorizer.lua',
    config = function() require'colorizer'.setup({
      '*'; -- Highlight all files, you can still customize others!
      -- '!vim'; -- Exclude vim from highlighting.
      css = { mode = 'background'; };
      html = { mode = 'background'; };
      packer = { RGB = false; }
    }, { mode = 'foreground'; }) end
  }

  use { -- Highlight, list and search todo comments
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function() require("plugins.todo-comments") end
  }

  use {  -- A pretty list for showing diagnostics, qf/loc lists
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function() require('plugins.trouble') end
  }

  use { -- Orgmode for Neovim, Life Organization Tool Written in Lua
    "nvim-neorg/neorg", ft = "norg", -- Lazyload
    config = function() require('plugins.neorg') end,
    requires = "nvim-lua/plenary.nvim"
  }


  --- Documentaiton / Markdown

  use { -- Personal Wiki for Vim
    'vimwiki/vimwiki',
    config = function()
      vim.g.vimwiki_list = {
        {
          'sindrets/diffview.nvim',
          config = function()
            require('plugins.diffview')
          end,
        },
      },
      config = function()
        require('plugins.neogit')
      end,
    })

    use({ -- Git signs written in pure lua
      'lewis6991/gitsigns.nvim',
      -- tag = 'release', -- To use the latest release
      event = { 'BufWinEnter', 'BufNewFile' },
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('plugins.gitsigns')
      end,
    })

    -- Language Utilities

    use({ -- Advnaced language parsing for neovim
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require('plugins.treesitter')
      end,
    })
    use({ 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' })

    use({ -- load extensions like VSCode and host language servers
      'neoclide/coc.nvim',
      branch = 'release',
      disable = true,
    })

    use({ -- Native language server protocol
      'williamboman/nvim-lsp-installer',
      requires = {
        'neovim/nvim-lspconfig',
        'hrsh7th/nvim-cmp',
      },
      config = function()
        require('lsp')
      end,
    })

    use({ -- Debug adapter protocol client
      'mfussenegger/nvim-dap',
      config = function()
        require('plugins.dap').config()
      end,
    })

    use({ -- Debugging interface for nvim-dap
      'rcarriga/nvim-dap-ui',
      requires = { 'mfussenegger/nvim-dap' },
      config = function()
        require('dapui').setup({
          mappings = {
            expand = { '<CR>', '<2-LeftMouse>', '<Tab>' },
          },
          sidebar = { position = 'right' },
        })
      end,
    })

    use({ -- Integration for nvim-dap with telescope.nvim
      'nvim-telescope/telescope-dap.nvim',
      after = { 'telescope.nvim', 'nvim-dap' },
    })

    -- Completion

    use({ -- Snippet Engine for Neovim
      'L3MON4D3/LuaSnip',
    })

    use({ -- vscode-like pictograms for neovim
      'onsails/lspkind-nvim',
    })

    use({ -- A completion plugin for neovim
      'hrsh7th/nvim-cmp',
      disable = false,
      -- event = { 'InsertEnter' },
      config = function()
        require('plugins.cmp')
      end,
      requires = {
        'f3fora/cmp-spell',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-calc',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-emoji',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'dmitmel/cmp-cmdline-history',
        'hrsh7th/cmp-nvim-lua',
        'onsails/lspkind-nvim',
        'saadparwaiz1/cmp_luasnip',
      },
    })

    use({ -- Alternative FileTree
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons', opts = true },
      config = function()
        require('plugins.nvimtree')
      end,
    })

    use({ -- easily manage multiple terminal windows
      'akinsho/toggleterm.nvim',
      config = function()
        require('plugins.toggleterm')
      end,
    })

    use({ -- autopairs for neovim written in lua
      'windwp/nvim-autopairs',
      config = function()
        require('plugins.autopairs')
      end,
    })

    use({ -- Neovim commenting plugin, written in lua
      'b3nj5m1n/kommentary',
      config = function()
        require('plugins.kommentary')
      end,
    })

    use({ -- A high-performance color highlighter
      'norcalli/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup({
          '*', -- Highlight all files, you can still customize others!
          -- '!vim'; -- Exclude vim from highlighting.
          css = { mode = 'background' },
          html = { mode = 'background' },
          packer = { RGB = false },
        }, { mode = 'foreground' })
      end,
    })

    use({ -- Highlight, list and search todo comments
      'folke/todo-comments.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('plugins.todo-comments')
      end,
    })

    use({ -- A pretty list for showing diagnostics, qf/loc lists
      'folke/trouble.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require('plugins.trouble')
      end,
    })

    use({ -- Orgmode for Neovim, Life Organization Tool Written in Lua
      'nvim-neorg/neorg',
      ft = 'norg', -- Lazyload
      config = function()
        require('plugins.neorg')
      end,
      requires = 'nvim-lua/plenary.nvim',
    })

    --- Documentaiton / Markdown

    use({ -- Personal Wiki for Vim
      'vimwiki/vimwiki',
      config = function()
        vim.g.vimwiki_list = {
          {
            path = '~/Documents/wiki',
            path_html = '~/Documents/wiki/_build/',
            links_space_char = ' ',
            syntax = 'markdown',
            ext = '.md',
          },
        }
      end,
    })

    use({ 'SidOfc/mkdx' })
    use({ -- Preview Markdown in the browser
      'iamcco/markdown-preview.nvim',
      ft = 'markdown',
      run = 'call mkdp#util#install()',
      config = function()
        vim.g.mkdp_auto_start = 1
      end,
    })

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

    vim.cmd([[
    augroup plugins_au
      autocmd!
      autocmd BufWritePost lua/plugins.lua source <afile> | PackerCompile
    augroup END
    ]])
  end,
  config = require('plugins.packer').config(),
})
