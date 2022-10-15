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

    use({ -- Render blank lines
      'lukas-reineke/indent-blankline.nvim',
      event = { 'BufWinEnter' },
      config = config('plugins.indent-blankline'),
    })

    --- Utilities ---

    use({ -- superior project management for neovim.
      'ahmedkhalf/project.nvim',
      config = config('plugins.project'),
    })

    use({ -- Highly extendable fuzzy finder
      'nvim-telescope/telescope.nvim',
      config = config('plugins.telescope'),
      requires = {
        { 'nvim-lua/popup.nvim' },
        { 'nvim-lua/plenary.nvim' },
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

    use({ -- Lua implementation of vim-which-key
      'folke/which-key.nvim',
      config = config('plugins.whichkey'),
    })

    --- Git: Version Control ---

    use({ -- A Git wrapper so awesome, it should be illegal
      'tpope/vim-fugitive',
      disable = false,
    })

    use({ -- Git signs written in pure lua
      'lewis6991/gitsigns.nvim',
      config = config('plugins.gitsigns'),
    })

    use({ -- Weapon to fight against conflicts in Vim.
      'rhysd/conflict-marker.vim',
      config = function()
        vim.cmd([[
        " disable the default highlight group
        let g:conflict_marker_highlight_group = ''

        " Include text after begin and end markers
        let g:conflict_marker_begin = '^<<<<<<< .*$'
        let g:conflict_marker_end   = '^>>>>>>> .*$'
        let g:conflict_marker_separator = '^=======$'

        highlight ConflictMarkerBegin guibg=#2f7366
        highlight ConflictMarkerOurs guibg=#2e5049
        highlight ConflictMarkerTheirs guibg=#344f69
        highlight ConflictMarkerEnd guibg=#2f628e
        highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
        ]])
      end,
    })

    use({ -- Magit for Neovim
      'TimUntersberger/neogit',
      disable = false,
      config = config('plugins.neogit'),
      requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'sindrets/diffview.nvim', config = config('plugins.diffview') },
      },
    })

    --- Language ---

    use({ -- Advanced language parsing for neovim
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = config('plugins.nvim-treesitter'),
    })
    use({ 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' })

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

    use({ 'arkav/lualine-lsp-progress' })

    use({ -- Standalone UI for nvim-lsp progress
      'j-hui/fidget.nvim',
      config = config('plugins.fidget'),
      disable = true,
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

    --- Completion ---

    use({ -- Snippet Engine for Neovim
      'L3MON4D3/LuaSnip',
    })

    use({ -- A completion plugin for neovim
      'hrsh7th/nvim-cmp',
      disable = false,
      -- event = { 'InsertEnter' },
      config = config('plugins.cmp'),
      requires = {
        'dmitmel/cmp-cmdline-history',
        'f3fora/cmp-spell',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-calc',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-emoji',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
      },
    })

    use({ -- Alternative File Tree
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons', opts = true },
      config = config('plugins.nvim-tree'),
    })

    use({ -- easily manage multiple terminal windows
      'akinsho/toggleterm.nvim',
      config = config('plugins.toggleterm'),
    })

    use({ -- autopairs for neovim written in lua
      'windwp/nvim-autopairs',
      config = config('plugins.autopairs'),
    })

    --- Documentation ---

    use({ -- Neovim commenting plugin, written in lua
      'b3nj5m1n/kommentary',
      config = config('plugins.kommentary'),
    })

    use({ -- A high-performance color highlighter
      'NvChad/nvim-colorizer.lua',
      config = config('plugins.colorizer'),
      event = { 'BufRead', 'BufWinEnter' },
    })

    use({ -- Highlight, list and search todo comments
      'folke/todo-comments.nvim',
      config = config('plugins.todo-comments'),
      requires = 'nvim-lua/plenary.nvim',
    })

    use({ -- A pretty list for showing diagnostics, qf/loc lists
      'folke/trouble.nvim',
      config = config('plugins.neorg'),
      requires = 'kyazdani42/nvim-web-devicons',
    })

    use({ -- Orgmode for Neovim, Life Organization Tool Written in Lua
      'nvim-neorg/neorg',
      ft = 'norg', -- Lazyload
      config = config('plugins.neorg'),
      requires = 'nvim-lua/plenary.nvim',
    })

    use({ -- Neovim extension for zk
      'mickael-menu/zk-nvim',
      config = config('plugins.zk'),
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

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins

    if packer_bootstrap then
      require('packer').sync()
    end

    vim.api.nvim_create_autocmd('BufWritePost', {
      desc = 'Update plugins and PackerCompile after buffer changes',
      group = vim.api.nvim_create_augroup('PackerBufWriteCompile', {}),
      pattern = { 'lua/plugins/init.lua' },
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
