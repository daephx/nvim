-- nvim-tree | file browser for neovim
-- https://github.com/kyazdani42/nvim-tree.lua
local nvimtree_ok, nvimtree = pcall(require, 'nvim-tree')
if not nvimtree_ok then
  return
end

--- Setup ---

nvimtree.setup({
  sort_by = 'case_sensitive',
  sync_root_with_cwd = true,
  disable_netrw = true,
  hijack_cursor = true,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = true,
  ignore_ft_on_setup = {},
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
      '.cache', -- General cache directory
      '.git', -- Git repository directory
      '__pycache__', -- Python cache directory
      'node_modules', -- Node module directory
    },
  },
  view = {
    width = 40,
    side = 'right',
    mappings = {
      custom_only = false,
      list = {},
    },
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    highlight_opened_files = '2',
    indent_markers = {
      enable = true,
    },
    icons = {
      git_placement = 'after',
    },
  },
})

vim.api.nvim_create_augroup('NvimTreeBuffer', {})
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Apply local settings to NvimTree buffer',
  group = 'NvimTreeBuffer',
  pattern = 'NvimTree',
  callback = function()
    -- Link NvimTree normal to higroup Normal
    vim.api.nvim_set_hl(0, 'NvimTreeNormal', { link = 'Normal' })
  end,
})
