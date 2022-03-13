" File: NoNuRelativeNormal.vim
" Description: Disable relative numbers in insert mode

" If either are empty, don't set autocmd group,
" This plugin requires you set both settings.
if (empty('&number') || empty('&relativenumber'))
  finish
endif

" Variable to check if the plugin is enabled by the user
let s:enabled = 1

" Disable plugin on certain file/buffer types
let s:exclude_filetypes = [
      \ 'NeogitCommitMessage',
      \ 'NeogitStatus',
      \ 'TelescopePrompt',
      \ 'dashboard',
      \ 'fugitive',
      \ 'gitcommit',
      \ 'help',
      \ 'log',
      \ 'packer',
      \]
let s:exclude_bufftypes = ['terminal', 'vim']

function! NoNuRelativeNormal(
      \ exclude_filetypes,
      \ exclude_bufftypes)

  " Avoid blacklist items
  if ( s:enabled == 0 ||
        \ index(a:exclude_filetypes, &ft) >= 0 ||
        \ index(a:exclude_bufftypes, &bt) >= 0)
    return
  endif

  if mode() == 'n'
    set norelativenumber
  else
    set relativenumber
  endif

endfunction


augroup NoNuRelativeInsert_au
  autocmd!
  autocmd InsertEnter,InsertLeavePre *
        \ call NoNuRelativeNormal(s:exclude_filetypes, s:exclude_bufftypes)
augroup END
