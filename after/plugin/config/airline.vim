" Airtable status line

" Refersh on source
" https://github.com/vim-airline/vim-airline/issues/1483
if exists(":AirlineRefresh")
    :AirlineRefresh
endif

set noshowmode " Remove mode indicator in command-line
set showtabline=2 " Always show tabs

" Switch to your current theme
let g:airline_theme = 'codedark'

" enable tabline
let g:airline#extensions#tabline#enabled = 1

" Just show the filename (no path) in the tab
let g:airline#extensions#tabline#fnamemod = ':t'

" enable powerline fonts
let g:airline_powerline_fonts = 1

" Disable arrows in status line
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
