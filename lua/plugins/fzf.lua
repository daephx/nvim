local g = vim.g

g.fzf_colors = {
  ['bg+'] = { 'bg', 'CursorLine', 'CursorColumn' },
  ['fg+'] = { 'fg', 'CursorLine', 'CursorColumn', 'Normal' },
  ['hl+'] = { 'fg', 'Statement' },
  bg = { 'bg', 'Normal' },
  fg = { 'fg', 'Normal' },
  hl = { 'fg', 'Comment' },
  border = { 'fg', 'Ignore' },
  header = { 'fg', 'Comment' },
  info = { 'fg', 'PreProc' },
  marker = { 'fg', 'Keyword' },
  pointer = { 'fg', 'Exception' },
  prompt = { 'fg', 'Conditional' },
  spinner = { 'fg', 'Label' },
}

vim.cmd([[
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --smart-case --glob "!{.git,node_modules,flow-typed}" -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
]])

--- Mappings ---

map('n', '<Leader>fh', '<cmd>History<CR>')
map('n', '<Leader>fb', '<cmd>Buffers<CR>')
map('n', '<Leader>ft', '<cmd>Files<CR>')
map('n', '<Leader>rg', '<ESC><cmd>RG<Space>')
map('n', '<Leader>rw', '<ESC><cmd>RG <C-R><C-W>')
map('n', '<Leader>rh', '<ESC><cmd>RG<UP><CR>')
