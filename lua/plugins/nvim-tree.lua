-- nvim-tree | file browser for neovim
-- URL: https://github.com/kyazdani42/nvim-tree.lua
local status_ok, nvimtree = pcall(require, 'nvim-tree')
if not status_ok then
  return
end

--- Setup ---

nvimtree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {},
  open_on_tab = false,
  hijack_cursor = true,
  update_cwd = true,
  update_to_buf_dir = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = ' ',
      info = ' ',
      warning = ' ',
      error = ' ',
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  system_open = {
    cmd = nil,
    args = {},
  },
  filters = {
    dotfiles = false,
    custom = {
      '.cache',
      '.git',
      '__pycache__',
      'node_modules',
    },
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 40,
    height = 30,
    side = 'right',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {},
    },
    number = false,
    relativenumber = false,
  },
  renderer = {
    add_trailing = false,
    highlight_git = true,
    highlight_opened_files = '2',
    indent_markers = {
      enable = true,
      icons = {
        corner = '└ ',
        edge = '│ ',
        none = '  ',
      },
    },
  },
  trash = {
    cmd = 'trash',
    require_confirm = true,
  },
  actions = {
    change_dir = {
      enable = true,
      global = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
    },
  },
})

vim.api.nvim_create_augroup('NvimTreeBuffer', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Apply local settings to NvimTree buffer',
  group = 'NvimTreeBuffer',
  pattern = 'NvimTree',
  callback = function()
    -- Highlights
    vim.api.nvim_set_hl(0, 'NvimTreeNormal', { link = 'Normal' })
    -- Settings
    vim.opt_local.cursorlineopt = 'both'
    vim.opt_local.cursorline = true
    vim.opt_local.statusline = ' '
    -- Keymaps
    local opts = { buffer = 0, silent = true, noremap = true }
    vim.keymap.set('n', '<esc>', '<cmd>q<cr>', opts)
  end,
})
