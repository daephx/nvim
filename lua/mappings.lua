-- Module: mappings
-- Description: Define key mappings for lua config

local api = vim.api


--- Mappings ---

-- Visually move lines <Up/Down>
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- Make Y act like other capitals
map('n', 'Y', 'y$')

-- Blackhole Registers
-- Breaks default functionality
map('v', '<del>', '"_d') -- Prevent <Delete> from yanking

-- Ctrl - hjkl to navigate splits
map('n', '<c-h>', '<cmd>wincmd h<CR>')
map('n', '<c-j>', '<cmd>wincmd j<CR>')
map('n', '<c-k>', '<cmd>wincmd k<CR>')
map('n', '<c-l>', '<cmd>wincmd l<CR>')

-- Visual indentation
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Formatting
-- TODO: Better formatting, check if lsp attachedm else rely on cmd / formatter.nvim
map('n', 'ff', '<cmd>lua vim.lsp.buf.formatting()<CR>') -- Activate LSP buffer formatter

-- Quickfix
map('n', '<c-q>', '<cmd>call ToggleQFList(1)<CR>')
map('n', '<localleader>q', '<cmd>call ToggleQFList(1)<CR>')
map('n', '<c-k>', '<cmd>cprev<CR>zz')
map('n', '<c-j>', '<cmd>cnext<CR>zz')


--- Terminal ---
map('t', '<leader><esc>', '<c-\\><c-n>') -- Double escape terminal mode
map('n', '<c-\\>', '<cmd>ToggleTerm direction=tab<CR>') -- Toggle tab terminal
map('n', '<c-\\><c-\\>', '<cmd>ToggleTerm direction=horizontal<CR>') -- Toggle horizontal terminal
map('t', '<c-\\>', '<c-\\><c-n><cmd>ToggleTerm<CR>') -- Escape and untoggle in terminal mode
map('t', '<c-w>', '<c-\\><c-n><c-w>')  -- Allow Ctrl+W to switch window in terminal mode
-- map('t', '<c-r>', '<c-r>')

map('n', '<c->`', '<cmd>ToggleTerm direction=horizontal<CR>') -- Toggle horizontal terminal

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end
-- cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


-- Diffsplit
-- map('n', 'q', "&diff ? '<cmd>tabclose<CR>' : 'q'")
vim.cmd [[ nnoremap <expr> q &diff ? '<cmd>tabclose<CR>' : 'q' ]]
