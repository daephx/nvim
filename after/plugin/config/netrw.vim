" --- Netrw ---

let g:netrw_browse_split = 0

" Disable netrw banner
let g:netrw_banner = 0

let g:netrw_winsize = 40

let g:netrw_localrmdir = 'rm'

" open file vertically to the right
augroup netrw_mappings
    autocmd!
    autocmd filetype netrw call Netrw_mappings()
augroup END

function! OpenToRight()
  :rightbelow vnew
  :wincmd p
  :normal P
endfunction

function! Netrw_mappings()
    noremap V :call OpenToRight()<cr>
endfunction
