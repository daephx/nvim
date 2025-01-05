-- neorg | The future of organizing your life in Neovim
-- https://github.com/nvim-neorg/neorg

---@type LazySpec
return {
  "nvim-neorg/neorg",
  ft = "norg",
  enabled = false,
  dependencies = {
    {
      "vhyrro/luarocks.nvim",
      -- Very high priority is required,
      -- luarocks.nvim should run as the first plugin in your config.
      priority = 1000,
      lazy = false,
      config = true,
    },
    -- Collection of useful lua functions
    "nvim-lua/plenary.nvim",
    -- Find, Filter, Preview, Pick. All lua, all the time
    "nvim-telescope/telescope.nvim",
    -- Nvim Treesitter configurations and abstraction layer
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    -- Tell Neorg what modules to load
    load = {
      -- Load all the default modules
      ["core.defaults"] = {},
      -- Configure core.keybinds
      ["core.keybinds"] = {
        config = {
          -- Generate the default keybinds
          default_keybinds = true,
          neorg_leader = "<Leader>o",
        },
      },
      ["core.norg.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
      -- Allows for use of icons
      ["core.norg.concealer"] = {},
      -- Manage your directories with Neorg
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            my_workspace = "~/Documents/neorg",
          },
        },
      },
    },
  },
}
