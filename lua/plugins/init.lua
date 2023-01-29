--     ____  __            _
--    / __ \/ /_  ______ _(_)___  _____
--   / /_/ / / / / / __ `/ / __ \/ ___/
--  / ____/ / /_/ / /_/ / / / / (__  )
-- /_/   /_/\__,_/\__, /_/_/ /_/____/
-- ==============/____/================
-- Plugin manager definitions & configs

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Initialize plugin list
require("lazy").setup({

  --- Colorschemes ---

  { -- Dark+ theme written in lua
    "Mofiqul/vscode.nvim",
    priority = 1000,
    config = function()
      require("colors.vscode")
    end,
  },
  { -- TokyoNight ColorScheme
    "folke/tokyonight.nvim",
    config = function()
      require("colors.tokyonight")
    end,
  },
  { -- Nice pink neovim color scheme
    "numtostr/sakura.nvim",
    config = function()
      require("colors.sakura")
    end,
  },
  { -- Retro groove color scheme for Vim
    "morhetz/gruvbox",
    config = function()
      require("colors.gruvbox")
    end,
  },

  --- User Interface ---

  { -- Dashboard / Start screen
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependices = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.dashboard")
    end,
  },
  { -- Blazing fast statusline
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.lualine")
    end,
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      -- Display LSP progress in the statusline
      "arkav/lualine-lsp-progress",
    },
  },
  { -- A "buffer and tab" tabline for neovim
    "kdheepak/tabline.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.tabline")
    end,
    dependencies = { "nvim-lualine/lualine.nvim" },
  },
  { -- Indent guides for Neovim
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    config = function()
      require("plugins.indent_blankline")
    end,
  },
  { -- Alternative File Tree
    "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("plugins.nvim-tree")
    end,
  },
  { -- Easily manage multiple terminal windows
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.toggleterm")
    end,
  },
  { -- Highlight, list and search todo comments
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = function()
      require("plugins.todo-comments")
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { -- A pretty list for showing diagnostics, qf/loc lists
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("plugins.trouble")
    end,
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },
  { -- A high-performance color highlighter
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("plugins.colorizer")
    end,
    event = { "BufRead", "BufWinEnter" },
  },
  { -- Neovim easymotions on speed!
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require("plugins.hop")
    end,
  },
  { -- The undo history visualizer for vim
    "mbbill/undotree",
  },

  --- Telescope ---

  { -- Highly extendable fuzzy finder
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-lua/popup.nvim" },
      { "kyazdani42/nvim-web-devicons" },
    },
    config = function()
      require("plugins.telescope")
    end,
  },
  { -- A small automated session manager for neovim
    "rmagatti/session-lens",
    lazy = false,
    dependencies = {
      "rmagatti/auto-session",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("plugins.auto-session")
    end,
  },
  { -- Superior project management for neovim.
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugins.project_nvim")
    end,
  },

  --- Git Integration ---

  { -- A Git wrapper so awesome, it should be illegal
    "tpope/vim-fugitive",
    config = function()
      require("plugins.fugitive")
    end,
  },
  { -- Magit for Neovim
    "TimUntersberger/neogit",
    cmd = "Neogit",
    config = function()
      require("plugins.neogit")
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { -- Easily cycling through diffs
        "sindrets/diffview.nvim",
        config = function()
          require("plugins.diffview")
        end,
      },
    },
  },
  { -- Git signs written in pure lua
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.gitsigns")
    end,
  },
  { -- Weapon to fight against conflicts in Vim.
    "akinsho/git-conflict.nvim",
    config = function()
      require("plugins.git-conflict")
    end,
  },

  --- Completion ---

  { -- Snippet Engine for Neovim written in Lua
    "L3MON4D3/LuaSnip",
    config = function()
      require("plugins.luasnip")
    end,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
  { -- A completion plugin for neovim coded in Lua
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    config = function()
      require("plugins.cmp")
    end,
    dependencies = {
      "dmitmel/cmp-cmdline-history",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  { -- Autopairs for neovim written in lua
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.nvim-autopairs")
    end,
  },
  { -- tab out from parens, quotes, and similar contexts
    "abecodes/tabout.nvim",
    config = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
    },
  },

  -- --- Language ---

  { -- Advanced language parsing for neovim
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("plugins.nvim-treesitter")
    end,
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    dependencies = {
      -- Rainbow parentheses for neovim using tree-sitter
      "p00f/nvim-ts-rainbow",
      -- Treesitter auto html tags
      "windwp/nvim-ts-autotag",
      -- Syntax aware text-objects, select, move, swap, etc
      "nvim-treesitter/nvim-treesitter-textobjects",
      { -- Treesitter playground integrated into Neovim
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
      },
      { -- Alternative to context.vim using nvim-treesitter
        "nvim-treesitter/nvim-treesitter-context",
        opts = { max_lines = 1 },
      },
    },
  },
  { -- Use Neovim as a language server
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { -- Initialize language server configuration
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      require("plugins.lsp")
    end,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jayp0521/mason-null-ls.nvim",
      -- LSP support in Neovim for eclipse.jdt.ls
      "mfussenegger/nvim-jdtls",
      -- Tools for better development in rust
      "simrat39/rust-tools.nvim",
      -- Neovim extension for zk
      "mickael-menu/zk-nvim",
    },
  },
  { -- Debug adapter protocol client
    "mfussenegger/nvim-dap",
    config = function()
      require("plugins.dap")
    end,
    dependencies = {
      { "rcarriga/nvim-dap-ui" },
      { "jbyuki/one-small-step-for-vimkind" },
    },
  },
  { -- Integration for nvim-dap with telescope.nvim
    "nvim-telescope/telescope-dap.nvim",
    config = function()
      require("telescope").load_extension("dap")
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap",
    },
  },
  { -- Smart and powerful comment plugin for neovim
    "numToStr/Comment.nvim",
    event = "BufReadPre",
    config = function()
      require("plugins.Comment")
    end,
  },
  { -- Support editorconfig for Neovim
    "gpanders/editorconfig.nvim",
    event = "BufReadPre",
    dependencies = {
      { -- Automatic indentation style detection
        "NMAC427/guess-indent.nvim",
        config = function()
          require("plugins.guess-indent")
        end,
      },
    },
  },
  { -- Orgmode for Neovim, Life Organization Tool Written in Lua
    "nvim-neorg/neorg",
    ft = "norg",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("plugins.neorg")
    end,
  },
  { -- Nice extra's for markdown documents
    "SidOfc/mkdx",
    ft = "markdown",
  },
  { -- Preview Markdown in the browser
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_preview_options = {
        hide_yaml_meta = 0,
        Disable_filename = 0,
        ["prefers-color-scheme"] = "dark",
      }
    end,
  },
  { -- Distraction-free coding for Neovim
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.zen-mode")
    end,
  },
  { -- Lua implementation of vim-which-key
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.which-key")
    end,
  },
  { -- spellcheck dictionary for programmers
    "psliwka/vim-dirtytalk",
    build = ":DirtytalkUpdate",
    event = "VeryLazy",
    config = function()
      -- HACK: Appends site directory to rtp for lazy
      -- https://github.com/psliwka/vim-dirtytalk/issues/25#issuecomment-1399267808
      vim.opt.rtp:append(vim.fn.stdpath("data") .. "/site")
      vim.opt.spelllang:append("programming")
    end,
  },
  { -- Prevent nested instances of neovim
    "samjwill/nvim-unception",
    config = function()
      vim.g.unception_enable_flavor_text = false
      vim.api.nvim_create_autocmd("User", {
        pattern = "UnceptionEditRequestReceived",
        callback = function()
          local wins = vim.api.nvim_list_wins()
          if #wins < 1 then
            vim.cmd("topleft split")
          end
          vim.api.nvim_set_current_win(wins[1])
        end,
      })
    end,
  },
}, {
  defaults = { lazy = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "single",
  },
})
