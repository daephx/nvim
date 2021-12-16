" File: git.vim
" Description: Extensions for git/fugitive related commands

" Allow diff to be open in a new tab
function! GdiffsplitTab(filename)
  if !empty(FugitiveGitDir())
    exe 'tabedit ' . a:filename
    Gdiffsplit
  endif
endfunction
command! GdiffsplitTab call GdiffsplitTab(expand("%"))

" Git commit log in new tab
function! GclogTab()
  if !empty(FugitiveGitDir())
    tabnew
    GcLog
  endif
endfunction
command! GclogTab call GclogTab()
