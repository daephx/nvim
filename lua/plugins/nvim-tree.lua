-- nvim-tree | file browser for neovim
-- https://github.com/kyazdani42/nvim-tree.lua
local nvimtree_ok, nvimtree = pcall(require, "nvim-tree")
if not nvimtree_ok then
  return
end

--- Setup ---

nvimtree.setup({
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
      ".cache", -- General cache directory
      ".git", -- Git repository directory
      "__pycache__", -- Python cache directory
      "node_modules", -- Node module directory
    },
  },
  view = {
    width = 40,
    side = "right",
    mappings = {
      custom_only = false,
      list = {},
    },
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    highlight_opened_files = "2",
    indent_markers = {
      enable = true,
    },
    icons = {
      git_placement = "after",
    },
  },
})
