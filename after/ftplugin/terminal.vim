" Settings
setlocal nobuflisted
setlocal nonumber
setlocal norelativenumber
setlocal signcolumn=
setlocal nowinfixheight

" Autocmds
augroup terminal_au
  autocmd!

  " Auto enter insert mode for terminal buffers
  " autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufEnter term://* startinsert
  autocmd BufLeave term://* stopinsert

  " Allow escape from terminal and fzfterm
  " autocmd TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  autocmd FileType fzf tunmap <buffer> <Esc>

augroup END
