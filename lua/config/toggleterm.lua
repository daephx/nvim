-- Prevent loading if not applicable
local ok, toggleterm = pcall(require, 'toggleterm')
if not ok then
  return
end

local Terminal = require('toggleterm.terminal').Terminal

toggleterm.setup({
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == 'horizontal' then
      return 20
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end,
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_terminals = false,
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = false,
  close_on_exit = true, -- close the terminal window when the process exits
  dir = vim.fn.getcwd(),
  direction = 'horizontal',
  float_opts = {
    border = 'curved',
    width = 190,
    height = 50,
    winblend = 8,
    highlights = {
      border = 'single',
      background = 'Normal',
    },
  },
})

local float_opts = {
  winblender = 0,
  highlights = {
    background = 'Normal',
    border = 'FloatBorder',
  },
}

--- Terminals ---

-- Export custom terminal settings for different use cases

local M = {}

M.default = Terminal:new({
  cmd = vim.o.shell,
  direction = 'horizontal',
  on_open = function(term)
    vim.cmd('startinsert!')
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      'n',
      'q',
      '<cmd>close<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      't',
      '<F12>',
      [[<C-\><C-n><cmd>lua toggle_terminal('default')<cr>]],
      { noremap = true, silent = true }
    )
  end,
})

M.lazygit = Terminal:new({
  cmd = 'lazygit',
  dir = vim.fn.getcwd(),
  hidden = false,
  on_open = function(term)
    if vim.fn.mapcheck('<esc>', 't') ~= '' then
      vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<esc>')
    end
  end,
  direction = 'float',
  float_opts = float_opts,
})

M.lazydocker = Terminal:new({
  cmd = 'lazydocker',
  dir = vim.fn.getcwd(),
  hidden = false,
  on_open = function(term)
    if vim.fn.mapcheck('<esc>', 't') ~= '' then
      vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<C-\\><C-N>')
    end
  end,
  direction = 'float',
  float_opts = float_opts,
})

_G.toggle_terminal = function(name)
  M[name]:toggle()
end

vim.cmd([[
command! -nargs=0 Lazygit lua toggle_terminal('lazygit')<cr>
command! -nargs=0 Lazydocker lua toggle_terminal('lazydocker')<cr>

" Explicitly disable signcolumn in toggleterm buffer
autocmd! FileType toggleterm setlocal signcolumn=no
]])

return M
