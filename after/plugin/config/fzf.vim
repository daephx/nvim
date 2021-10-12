" Fzf Configurations

" Prevent execution if plugin not found
if !exists('g:loaded_fzf')
  finish
endif

" TODO: Further testing is required!
" Set default fzf command args
" use this if it's not set by your shell
" if !exists('$FZF_DEFAULT_COMMAND')
"   let $FZF_DEFAULT_COMMAND =
"     \ 'fdfind --type -f --hidden --follow --exclude .git'
" endif

" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }


" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


" tnoremap <silent> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunc

let g:fzf_action =
\ { 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-h': 'split',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-x': 'silent exec "!echo"' }
