-- nvim-tree | file browser for neovim

local g = vim.g

-- Prevent loading if not applicable
local ok, nvimtree = pcall(require, 'nvim-tree')
if not ok then
  return
end

--- Globals ---

-- Will enable file highlight for git attributes (can be used without the icons)
g.nvim_tree_git_hl = 1
-- Will enable folder and file icon highlight for opened files/directories
g.nvim_tree_highlight_opened_files = 1
-- Append a trailing slash to folder names
g.nvim_tree_add_trailing = 0

--- Setup ---

nvimtree.setup({
  -- disables netrw completely
  disable_netrw = true,
  -- hijack netrw window on startup
  hijack_netrw = true,
  -- open the tree when running this setup function
  open_on_setup = false,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup = {},
  -- closes neovim automatically when the tree is the last **WINDOW** in the view
  auto_close = false,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab = false,
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor = true,
  -- Auto update current directory
  update_cwd = true,
  -- hijacks new directory buffers when they are opened.
  update_to_buf_dir = {
    -- enable the feature
    enable = true,
    -- allow to open the tree if it was previously closed
    auto_open = true,
  },
  -- show lsp diagnostics in the signcolumn
  diagnostics = {
    enable = true,
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
  -- update the focused file on `BufEnter`,
  -- un-collapses the folders recursively until it finds the file
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd = nil,
    -- the command arguments as a list
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
    -- width of the window, can be either a number (columns)
    -- or a string in `%`, for left or right side placement
    width = 40,
    -- height of the window, can be either a number (columns)
    -- or a string in `%`, for top or bottom side placement
    height = 30,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'right',
    -- if true the tree will resize itself after opening a file
    auto_resize = false,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {},
    },
    number = false,
    relativenumber = false,
  },
  renderer = {
    -- This option shows indent markers when folders are open.
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
      -- closes tree when file's opened.
      quit_on_open = false,
      resize_window = false,
    },
  },
})

vim.cmd([[
  highlight NvimTreeNormal guibg=none

  function! DisableST()
    return " "
  endfunction
  au! BufEnter NvimTree setlocal statusline=%!DisableST()
  \| setlocal cursorline cursorlineopt=both
]])
