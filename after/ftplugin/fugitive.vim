" Allow diff to be open in a new tab
command! GdiffsplitTab call GdiffsplitTab(expand("%"))
function! GdiffsplitTab(filename)
    exe 'tabedit ' . a:filename
    Gdiffsplit
endfunction

" Settings to apply to local buffer
function! s:fugitive_settings()
  setlocal nonumber
  setlocal norelativenumber
  setlocal colorcolumn=0
  setlocal foldmethod=syntax
endfunction


augroup fugitive_au
  au!
  au FileType fugitive call s:fugitive_settings()
  au User FugitiveIndex nmap <buffer> dt :Gtabedit <Plug><cfile><Bar>Gdiffsplit<CR>
  au User FugitiveIndex nmap <buffer> <tab> =
augroup END
