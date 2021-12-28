" Terminal.vim
" Apply settings for terminal buffers

function! TerminalSettings()
  setlocal nobuflisted
  setlocal nonumber
  setlocal norelativenumber
  setlocal signcolumn=no
  setlocal nowinfixheight
  setlocal nospell
endfunction

" Autocmds
augroup terminal_au
  autocmd!

  " Apply local buffer settings
  autocmd! TermOpen * call TerminalSettings()

  " Auto enter insert mode for terminal buffers
  " autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufEnter term://* startinsert
  autocmd BufLeave term://* stopinsert

  " Allow escape from terminal and fzfterm
  " autocmd TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  autocmd FileType fzf tunmap <buffer> <Esc>

augroup END
