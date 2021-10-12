" NERDTree Configuration

" Prevent setup if not plugin not loaded
if !exists('*minpac#init') | finish | endif
if !get(g:, 'loaded_nerdtree', 0)
  finish
endif

" NERDTree Right-hand side
let g:NERDTreeWinPos = "right"

" Map F6 to toggle NERDTree
nmap <F6> :NERDTreeToggle<CR>

" autocmd BufEnter * :NERDTree
autocmd FileType nerdtree setlocal winfixwidth


" Open nerdtree on startup if no file specified
" NOTE: Causes some issues with plugins like dashboard-nvim
"       Resaulting the the dashboard disaprearing
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" NOTE: I don't think that means, what you think it means.
" autocmd FileType nerdtree setlocal noequalalways

" NOTE: This seems to work as expected!
" Attempt to close vim if NERDTree is the only window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
