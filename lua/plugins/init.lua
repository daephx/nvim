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

-- Generate plugin config string for packer compile
---@param name string
---@return function
local config = function(name)
  return function()
    require(name)
  end
end

-- Initialize plugin list
require("lazy").setup({

  --- Colorschemes ---

  { -- Dark+ theme written in lua
    "Mofiqul/vscode.nvim",
    priority = 1000,
    config = config("colors.vscode"),
  },
  { -- TokyoNight ColorScheme
    "folke/tokyonight.nvim",
    config = config("colors.tokyonight"),
  },
  { -- Nice pink neovim color scheme
    "numtostr/sakura.nvim",
    config = config("colors.sakura"),
  },
  { -- Retro groove color scheme for Vim
    "morhetz/gruvbox",
    config = config("colors.gruvbox"),
  },

  --- User Interface ---

  { -- Dashboard / Start screen
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = config("plugins.dashboard"),
  },
  { -- Blazing fast statusline
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = config("plugins.lualine"),
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      -- Display LSP progress in the statusline
      "arkav/lualine-lsp-progress",
    },
  },
  { -- Indent guides for Neovim
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    config = config("plugins.indent_blankline"),
  },
  { -- Alternative File Tree
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = config("plugins.nvim-tree"),
  },
  { -- Easily manage multiple terminal windows
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    config = config("plugins.toggleterm"),
  },
  { -- Highlight, list and search todo comments
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = config("plugins.todo-comments"),
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { -- A pretty list for showing diagnostics, qf/loc lists
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = config("plugins.trouble"),
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { -- A high-performance color highlighter
    "NvChad/nvim-colorizer.lua",
    config = config("plugins.colorizer"),
    event = { "BufRead", "BufWinEnter" },
  },
  { -- Neovim easymotions on speed!
    "phaazon/hop.nvim",
    branch = "v2",
    config = config("plugins.hop"),
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
      { "nvim-tree/nvim-web-devicons" },
    },
    config = config("plugins.telescope"),
  },
  { -- A small automated session manager for neovim
    "rmagatti/session-lens",
    lazy = false,
    dependencies = {
      "rmagatti/auto-session",
      "nvim-telescope/telescope.nvim",
    },
    config = config("plugins.auto-session"),
  },
  { -- Superior project management for neovim.
    "ahmedkhalf/project.nvim",
    config = config("plugins.project_nvim"),
  },

  --- Git Integration ---

  { -- A Git wrapper so awesome, it should be illegal
    "tpope/vim-fugitive",
    config = config("plugins.fugitive"),
  },
  { -- Magit for Neovim
    "TimUntersberger/neogit",
    cmd = "Neogit",
    config = config("plugins.neogit"),
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { -- Easily cycling through diffs
        "sindrets/diffview.nvim",
        config = config("plugins.diffview"),
      },
    },
  },
  { -- Git signs written in pure lua
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = config("plugins.gitsigns"),
  },
  { -- Weapon to fight against conflicts in Vim.
    "akinsho/git-conflict.nvim",
    event = "BufReadPre",
    version = "*",
    config = config("plugins.git-conflict"),
  },

  --- Completion ---

  { -- Snippet Engine for Neovim written in Lua
    "L3MON4D3/LuaSnip",
    config = config("plugins.luasnip"),
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
  },
  { -- A completion plugin for neovim coded in Lua
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    config = config("plugins.cmp"),
    dependencies = {
      "dmitmel/cmp-cmdline-history",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  { -- Autopairs for neovim written in lua
    "windwp/nvim-autopairs",
    config = config("plugins.nvim-autopairs"),
  },
  { -- tab out from parens, quotes, and similar contexts
    "abecodes/tabout.nvim",
    enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
    },
  },

  -- --- Language ---

  { -- Advanced language parsing for neovim
    "nvim-treesitter/nvim-treesitter",
    config = config("plugins.nvim-treesitter"),
    build = ":TSUpdate",
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
    event = "VimEnter",
    config = config("plugins.lsp"),
    dependencies = {
      -- Portable package manager for Neovim
      {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
      },
      -- bridges mason.nvim with the nvim-dap
      "williamboman/mason-lspconfig.nvim",
      -- bridges mason.nvim with the null-ls
      "jayp0521/mason-null-ls.nvim",
      -- bridges mason.nvim with the nvim-dap
      "jay-babu/mason-nvim-dap.nvim",
      -- LSP support in Neovim for eclipse.jdt.ls
      "mfussenegger/nvim-jdtls",
      -- Tools for better development in rust
      "simrat39/rust-tools.nvim",
      -- Neovim extension for zk
      "mickael-menu/zk-nvim",
    },
  },
  { -- A VS Code like winbar for Neovim
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    event = "BufReadPost",
    config = config("plugins.barbecue"),
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
  },
  { -- Debug adapter protocol client
    "mfussenegger/nvim-dap",
    config = config("plugins.dap"),
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
  { -- LSP signature hint as you type
    "ray-x/lsp_signature.nvim",
    config = config("plugins.lsp_signature"),
  },
  { -- Smart and powerful comment plugin for neovim
    "numToStr/Comment.nvim",
    event = "BufReadPre",
    config = config("plugins.Comment"),
  },
  { -- Support editorconfig for Neovim
    "gpanders/editorconfig.nvim",
    event = "BufReadPre",
    dependencies = {
      { "tpope/vim-sleuth" },
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
    config = config("plugins.neorg"),
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
    config = config("plugins.zen-mode"),
  },
  { -- Lua implementation of vim-which-key
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = config("plugins.which-key"),
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
    border = vim.g.border,
  },
})

vim.api.nvim_create_autocmd("BufRead", {
  desc = "Prevent lazy lockfile from being modified",
  pattern = "lazy-lock.json",
  command = "setlocal readonly",
})
