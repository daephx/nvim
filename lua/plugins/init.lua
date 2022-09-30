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

-- Initialize packer plugin
local ok, packer = pcall(require, 'packer')
if not ok then
  require('plugins.packer').bootstrap()
  packer = require('packer')
end

function get_setup(name)
  return table.concat({
    string.format('local ok, mod = pcall(require, "%s")', name),
    'if (type(mod) == "table") then local func = mod.setup end',
    'if func then func() end',
  }, '\n')
end

--- Plugins ---

-- Initialize plugin list
return packer.startup({
  function(use)
    use({ -- Packer can manage itself
      'wbthomason/packer.nvim',
    })

    -- ======================================
    -- * Place your plugin definitions here *
    -- ======================================

    use({ -- Dark+ theme written in lua
      'Mofiqul/vscode.nvim',
      config = get_setup('colors.vscode'),
    })

    use({ -- TokyoNight ColorScheme
      'folke/tokyonight.nvim',
      config = get_setup('colors.tokyonight'),
    })

    use({ -- Nice pink neovim color scheme
      'numtostr/sakura.nvim',
      config = get_setup('colors.vscode'),
    })

    use({ -- Retro groove color scheme for Vim
      'morhetz/gruvbox',
      config = get_setup('colors.gruvbox'),
    })

    use({ -- Dashboard / Start screen
      'glepnir/dashboard-nvim',
      config = get_setup('plugins.dashboard'),
    })

    use({ -- A "buffer and tab" tabline for neovim
      'kdheepak/tabline.nvim',
      requires = { 'nvim-lualine/lualine.nvim', opt = true },
      config = get_setup('plugins.tabline'),
    })

    use({ -- Blazing fast statusline
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = get_setup('plugins.lualine'),
    })

    use({ -- Render blank lines
      'lukas-reineke/indent-blankline.nvim',
      event = { 'BufWinEnter' },
      config = get_setup('plugins.indent-blankline'),
    })

    --- Utilities ---

    use({ -- FZF - Command line fuzzy-finder
      'junegunn/fzf.vim',
      disable = true,
      requires = { 'junegunn/fzf', dir = '~/.fzf', run = './install --all' },
      config = get_setup('plugins.fzf'),
    })

    use({ -- superior project management for neovim.
      'ahmedkhalf/project.nvim',
      config = get_setup('plugins.project'),
    })

    use({ -- Highly extendable fuzzy finder
      'nvim-telescope/telescope.nvim',
      config = get_setup('plugins.telescope'),
      requires = {
        { 'nvim-lua/popup.nvim' },
        { 'nvim-lua/plenary.nvim' },
        { -- FZF sorter for telescope written in c
          'nvim-telescope/telescope-fzf-native.nvim',
          run = 'make',
          disable = true,
        },
      },
    })

    use({ -- A small automated session manager for neovim
      'rmagatti/auto-session',
      config = get_setup('plugins.auto-session'),
      requires = {
        'rmagatti/session-lens',
        'rmagatti/auto-session',
        'nvim-telescope/telescope.nvim',
      },
    })

    use({ -- Lua implementation of vim-which-key
      'folke/which-key.nvim',
      config = get_setup('plugins.whichkey'),
    })

    --- Git: Version Control ---

    use({ -- A Git wrapper so awesome, it should be illegal
      'tpope/vim-fugitive',
      disable = false,
    })

    use({ -- Git signs written in pure lua
      'lewis6991/gitsigns.nvim',
      config = get_setup('plugins.gitsigns'),
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
      config = get_setup('plugins.neogit'),
      requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'sindrets/diffview.nvim', config = get_setup('plugins.diffview') },
      },
    })

    --- Language ---

    use({ -- Advanced language parsing for neovim
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = get_setup('plugins.nvim-treesitter'),
    })
    use({ 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' })

    use({ -- Use Neovim as a language server
      'jose-elias-alvarez/null-ls.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
    })

    use({ -- load extensions like VSCode and host language servers
      'neoclide/coc.nvim',
      branch = 'release',
      disable = true,
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
      config = get_setup('plugins.fidget'),
      disable = true,
    })

    use({ -- Debug adapter protocol client
      'mfussenegger/nvim-dap',
      config = get_setup('plugins.dap'),
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
      config = get_setup('plugins.cmp'),
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
      config = get_setup('plugins.nvim-tree'),
    })

    use({ -- easily manage multiple terminal windows
      'akinsho/toggleterm.nvim',
      config = get_setup('plugins.toggleterm'),
    })

    use({ -- autopairs for neovim written in lua
      'windwp/nvim-autopairs',
      config = get_setup('plugins.autopairs'),
    })

    --- Documentation ---

    use({ -- Neovim commenting plugin, written in lua
      'b3nj5m1n/kommentary',
      config = get_setup('plugins.kommentary'),
    })

    use({ -- A high-performance color highlighter
      'NvChad/nvim-colorizer.lua',
      config = get_setup('plugins.colorizer'),
      event = { 'BufRead', 'BufWinEnter' },
    })

    use({ -- Highlight, list and search todo comments
      'folke/todo-comments.nvim',
      config = get_setup('plugins.todo-comments'),
      requires = 'nvim-lua/plenary.nvim',
    })

    use({ -- A pretty list for showing diagnostics, qf/loc lists
      'folke/trouble.nvim',
      config = get_setup('plugins.neorg'),
      requires = 'kyazdani42/nvim-web-devicons',
    })

    use({ -- Orgmode for Neovim, Life Organization Tool Written in Lua
      'nvim-neorg/neorg',
      ft = 'norg', -- Lazyload
      config = get_setup('plugins.neorg'),
      requires = 'nvim-lua/plenary.nvim',
    })

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

    vim.cmd([[
    augroup plugins_au
      autocmd!
      autocmd BufWritePost lua/plugins.lua source <afile> | PackerCompile
    augroup END
    ]])
  end,

  -- Load and evaluate packer config table
  config = (require('plugins.packer').setup)(),
})
