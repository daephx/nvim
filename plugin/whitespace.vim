" File: whitespace.vim
" Description: Plugin for cleaning up whitespace and newlines

" Trim extra whitespace
function! StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  if &filetype != 'markdown' " HACK: ignore markdown
    %s/\s\+$//e " Do the business
  endif
  " Clean up: restore previous search history / cursor
  let @/=_s
  call cursor(l, c)
endfunction

" Trim extra newlines at EOF
function! StripTrailingNewlines()
  let save_cursor = getpos(".")
  silent! %s#\($\n\s*\)\+\%$##
  call setpos('.', save_cursor)
endfunction


augroup whitespace_au
  autocmd!
  autocmd BufWritePre * :call StripTrailingNewlines()
  autocmd BufWritePre * :call StripTrailingWhitespaces()
augroup END
