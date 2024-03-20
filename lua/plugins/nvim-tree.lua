-- nvim-tree | file browser for neovim
-- https://github.com/kyazdani42/nvim-tree.lua

---@type LazyPluginSpec
return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeOpen", "NvimTreeToggle" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
  },
  opts = {
    sort_by = "case_sensitive",
    sync_root_with_cwd = true,
    disable_netrw = true,
    hijack_cursor = true,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = true,
    hijack_directories = {
      enable = true,
      auto_open = true,
    },
    diagnostics = {
      enable = true,
    },
    update_focused_file = {
      enable = true,
      update_root = true,
      ignore_list = {},
    },
    filters = {
      dotfiles = false,
      custom = {
        "^.cache$", -- General cache directory
        "^.git$", -- Git repository directory
        "__pycache__", -- Python cache directory
        "node_modules", -- Node module directory
      },
    },
    view = {
      width = 40,
      side = "right",
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
      highlight_opened_files = "icon",
      indent_markers = {
        enable = true,
      },
      icons = {
        git_placement = "after",
      },
    },
  },
  config = function(_, opts)
    -- initialize plugin
    require("nvim-tree").setup(opts)

    -- HACK: Close nvimtree window when leaving vim,
    -- Prevents Compatibility issues with auto-session
    -- https://github.com/nvim-tree/nvim-tree.lua/issues/1992
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "NvimTree" },
      callback = function(args)
        vim.api.nvim_create_autocmd("VimLeavePre", {
          callback = function()
            vim.api.nvim_buf_delete(args.buf, { force = true })
            return true
          end,
        })
      end,
    })
  end,
}
