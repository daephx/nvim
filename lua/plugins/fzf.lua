local api = vim.api
local cmd = vim.cmd
local g = vim.g

g.fzf_colors = {
  fg      = { 'fg', 'Normal' },
  bg      = { 'bg', 'Normal' },
  hl      = { 'fg', 'Comment' },
  ['fg+'] = { 'fg', 'CursorLine', 'CursorColumn', 'Normal' },
  ['bg+'] = { 'bg', 'CursorLine', 'CursorColumn' },
  ['hl+'] = { 'fg', 'Statement' },
  info    = { 'fg', 'PreProc' },
  border  = { 'fg', 'Ignore' },
  prompt  = { 'fg', 'Conditional' },
  pointer = { 'fg', 'Exception' },
  marker  = { 'fg', 'Keyword' },
  spinner = { 'fg', 'Label' },
  header  = { 'fg', 'Comment' }
}

cmd [[
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --smart-case --glob "!{.git,node_modules,flow-typed}" -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
]]


--- Mappings ---

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }

map('n', '<Leader>fh', ':History<CR>', opts)
map('n', '<Leader>fb', ':Buffers<CR>', opts)
map('n', '<Leader>ft', ':Files<CR>', opts)
map('n', '<Leader>rg', '<ESC>:RG<Space>', opts)
map('n', '<Leader>rw', '<ESC>:RG <C-R><C-W>', opts)
map('n', '<Leader>rh', '<ESC>:RG<UP><CR>', opts)
