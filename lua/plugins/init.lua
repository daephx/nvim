--     ____  __            _
--    / __ \/ /_  ______ _(_)___  _____
--   / /_/ / / / / / __ `/ / __ \/ ___/
--  / ____/ / /_/ / /_/ / / / / (__  )
-- /_/   /_/\__,_/\__, /_/_/ /_/____/
-- ==============/____/================
-- Packer plugin definitions and config

-- Load local packer functions
local packer_bootstrap = require('plugins.packer').ensure_packer()
local config = require('plugins.packer').config

-- Initialize plugin list
return require('packer').startup({
  function(use)
    use({ -- Packer can manage itself
      'wbthomason/packer.nvim',
    })

    -- ======================================
    -- * Place your plugin definitions here *
    -- ======================================

    use({ -- Dark+ theme written in lua
      'Mofiqul/vscode.nvim',
      config = config('colors.vscode'),
    })

    use({ -- TokyoNight ColorScheme
      'folke/tokyonight.nvim',
      config = config('colors.tokyonight'),
    })

    use({ -- Nice pink neovim color scheme
      'numtostr/sakura.nvim',
      config = config('colors.sakura'),
    })

    use({ -- Retro groove color scheme for Vim
      'morhetz/gruvbox',
      config = config('colors.gruvbox'),
    })

    use({ -- Dashboard / Start screen
      'glepnir/dashboard-nvim',
      config = config('plugins.dashboard'),
    })

    use({ -- A "buffer and tab" tabline for neovim
      'kdheepak/tabline.nvim',
      requires = { 'nvim-lualine/lualine.nvim', opt = true },
      config = config('plugins.tabline'),
    })

    use({ -- Blazing fast statusline
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = config('plugins.lualine'),
    })

    use({ -- Display LSP progress in the statusline
      'arkav/lualine-lsp-progress',
      after = { 'lualine.nvim' },
      require = {
        'nvim-lualine/lualine.nvim',
        'neovim/nvim-lspconfig',
      },
    })

    use({ -- Indent guides for Neovim
      'lukas-reineke/indent-blankline.nvim',
      config = config('plugins.indent-blankline'),
    })

    --- Utilities ---

    use({ -- Alternative File Tree
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons', opts = true },
      config = config('plugins.nvim-tree'),
    })

    use({ -- easily manage multiple terminal windows
      'akinsho/toggleterm.nvim',
      config = config('plugins.toggleterm'),
    })

    use({ -- Highlight, list and search todo comments
      'folke/todo-comments.nvim',
      config = config('plugins.todo-comments'),
      requires = 'nvim-lua/plenary.nvim',
    })

    use({ -- A pretty list for showing diagnostics, qf/loc lists
      'folke/trouble.nvim',
      cmd = { 'Trouble', 'TroubleClose', 'TroubleRefresh', 'TroubleToggle' },
      config = config('plugins.trouble'),
      requires = { 'kyazdani42/nvim-web-devicons' },
    })

    use({ -- A high-performance color highlighter
      'NvChad/nvim-colorizer.lua',
      config = config('plugins.colorizer'),
      event = { 'BufRead', 'BufWinEnter' },
    })

    --- Telescope ---

    use({ -- Highly extendable fuzzy finder
      'nvim-telescope/telescope.nvim',
      config = config('plugins.telescope'),
      requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-lua/popup.nvim' },
      },
    })

    use({ -- A small automated session manager for neovim
      'rmagatti/auto-session',
      config = config('plugins.auto-session'),
      requires = {
        'rmagatti/session-lens',
        'rmagatti/auto-session',
        'nvim-telescope/telescope.nvim',
      },
    })

    use({ -- superior project management for neovim.
      'ahmedkhalf/project.nvim',
      config = config('plugins.project'),
    })

    --- Completion ---

    use({ -- Snippet Engine for Neovim
      'L3MON4D3/LuaSnip',
    })

    use({ -- A completion plugin for neovim coded in Lua
      'hrsh7th/nvim-cmp',
      config = config('plugins.cmp'),
      requires = {
        'dmitmel/cmp-cmdline-history',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
      },
    })

    use({ -- autopairs for neovim written in lua
      'windwp/nvim-autopairs',
      config = config('plugins.autopairs'),
    })

    --- Git: Version Control ---

    use({ -- A Git wrapper so awesome, it should be illegal
      'tpope/vim-fugitive',
    })

    use({ -- Magit for Neovim
      'TimUntersberger/neogit',
      config = config('plugins.neogit'),
      requires = {
        { 'nvim-lua/plenary.nvim' },
        {
          'sindrets/diffview.nvim',
          config = config('plugins.diffview'),
        },
      },
    })

    use({ -- Git signs written in pure lua
      'lewis6991/gitsigns.nvim',
      config = config('plugins.gitsigns'),
    })

    use({ -- Weapon to fight against conflicts in Vim.
      'akinsho/git-conflict.nvim',
      config = config('plugins.git-conflict'),
    })

    --- Language ---

    use({ -- Advanced language parsing for neovim
      'nvim-treesitter/nvim-treesitter',
      config = config('plugins.nvim-treesitter'),
      -- NOTE: Using `TSUpdate` for packer.run will cause error on a clean install
      -- https://github.com/rafamadriz/dotfiles/commit/c1268c73bdc7da52af0d57dcbca196ca3cb5ed79
      run = function()
        require('nvim-treesitter.install').update({ with_sync = true })
      end,
    })

    use({ -- Rainbow parentheses for neovim using tree-sitter
      'p00f/nvim-ts-rainbow',
    })

    use({ -- Treesitter auto html tags
      'windwp/nvim-ts-autotag',
      after = 'nvim-treesitter',
    })

    use({ -- Treesitter playground integrated into Neovim
      'nvim-treesitter/playground',
      cmd = 'TSPlaygroundToggle',
    })

    use({ -- Syntax aware text-objects, select, move, swap, and peek
      'nvim-treesitter/nvim-treesitter-textobjects',
      after = 'nvim-treesitter',
    })

    use({ -- Alternative to context.vim using nvim-treesitter
      'nvim-treesitter/nvim-treesitter-context',
      after = 'nvim-treesitter',
      config = function()
        local ts_ctx_ok, ts_ctx = pcall(require, 'treesitter-context')
        if not ts_ctx_ok then
          return
        end

        ts_ctx.setup({ max_lines = 1 })
      end,
    })

    use({ -- Use Neovim as a language server
      'jose-elias-alvarez/null-ls.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
    })

    use({ -- Native language server protocol
      'williamboman/nvim-lsp-installer',
      requires = { 'neovim/nvim-lspconfig' },
      config = function()
        require('lsp').setup({
          config_path = 'lua/lsp/servers',
        })
      end,
    })

    use({ -- Debug adapter protocol client
      'mfussenegger/nvim-dap',
      config = config('plugins.dap'),
    })

    use({ -- Debugging interface for nvim-dap
      'rcarriga/nvim-dap-ui',
      requires = { 'mfussenegger/nvim-dap' },
    })

    use({ -- Integration for nvim-dap with telescope.nvim
      'nvim-telescope/telescope-dap.nvim',
      after = { 'telescope.nvim', 'nvim-dap' },
    })

    use({ -- Smart and powerful comment plugin for neovim
      'numToStr/Comment.nvim',
      config = config('plugins.Comment'),
      -- Event = 'BufRead',
    })

    use({ -- Orgmode for Neovim, Life Organization Tool Written in Lua
      'nvim-neorg/neorg',
      after = { 'nvim-treesitter', 'telescope.nvim' },
      config = config('plugins.neorg'),
      ft = 'norg',
      requires = { 'nvim-lua/plenary.nvim' },
      run = ':Neorg sync-parsers',
    })

    use({ -- Neovim extension for zk
      'mickael-menu/zk-nvim',
      config = config('plugins.zk'),
    })

    use({ -- Nice extra's for markdown documents
      'SidOfc/mkdx',
      ft = 'markdown',
    })

    use({ -- Preview Markdown in the browser
      'iamcco/markdown-preview.nvim',
      ft = 'markdown',
      run = function()
        vim.fn['mkdp#util#install']()
      end,
      config = function()
        vim.g.mkdp_auto_start = 0
        vim.g.mkdp_preview_options = {
          hide_yaml_meta = 0,
          Disable_filename = 0,
          ['prefers-color-scheme'] = 'dark',
        }
      end,
    })

    use({ -- Distraction-free coding for Neovim
      'folke/zen-mode.nvim',
      config = config('plugins.zen-mode'),
    })

    use({ -- Lua implementation of vim-which-key
      'folke/which-key.nvim',
      config = config('plugins.whichkey'),
    })

    -- ======================================
    -- *       END OF PLUGIN SECTION       *
    -- ======================================

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins

    if packer_bootstrap then
      require('packer').sync()
    end

    vim.api.nvim_create_autocmd('BufWritePost', {
      desc = 'Update plugins and PackerCompile after buffer changes',
      group = vim.api.nvim_create_augroup('PackerBufWriteCompile', {}),
      pattern = { string.format('%s/lua/plugins/init.lua', vim.fn.getcwd()) },
      callback = function(opts)
        vim.notify('Packer: Recompiling plugins', vim.log.levels.INFO)
        dofile(opts.match)
        require('packer').compile()
      end,
    })
  end,

  -- Load and evaluate packer config table
  config = (require('plugins.packer').setup)(),
})
