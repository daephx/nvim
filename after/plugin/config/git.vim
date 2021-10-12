" File: git.vim
" Description: Settings for git integration
" Includes plugin configuations for plugings such as 'vim-fugitive'
" certain sections should only load if the plugin can be verified.

" --- Initalization ---


" --- Fugitive ---

" Verify plugin exists before proceeding
if !&rtp =~ 'vim-fugitive' | finish | endif


function! ToggleGitWindow()
  if buflisted(bufname('.git/index'))
    bd .git/index
  else
    Git
    20wincmd_
  endif
endfunction
" command! Git :call ToggleGitWindow()
" nnoremap <silent> <leader>gg :ToggleGitWindow()<cr>

" TODO: The goal is to make the git status window togglable
"       as well as control the size of the split.
" Reference: https://github.com/tpope/vim-fugitive/issues/401#issuecomment-735951317

augroup fugitive_au
  autocmd!
  autocmd FileType fugitive setlocal winfixheight
augroup END
