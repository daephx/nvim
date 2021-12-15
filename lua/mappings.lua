-- Module: mappings
-- Description: Define key mappings for lua config

local api = vim.api


--- Mappings ---

-- Visually move lines <Up/Down>
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- Ctrl - hjkl to navigate splits
map('n', '<c-h>', '<cmd>wincmd h<CR>')
map('n', '<c-j>', '<cmd>wincmd j<CR>')
map('n', '<c-k>', '<cmd>wincmd k<CR>')
map('n', '<c-l>', '<cmd>wincmd l<CR>')
