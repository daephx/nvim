-- Module: mappings
-- Description: Define key mappings for lua config

local api = vim.api


--- Mappings ---

-- Visually move lines <Up/Down>
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")
