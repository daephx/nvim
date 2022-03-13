" File: MkNonExDir.vim
" Description:
" When writing a new file,
" create the directory path if it doesn't exists

" TODO(daephx): Query user to confirm creation of new paths
" Recursive write to non-existent directory
function s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction

augroup MkNonExDir_au
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
