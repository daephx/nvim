" File: tokyonight.vim
" Description: Color settings for tokyonight theme

" --- Initialization ---

" Prevent loading if not applicable
if !exists('g:colors_name')
    \ || g:colors_name != 'tokyonight'
  finish
endif

" --- Settings ---

let g:tokyonight_style = 'night'
let g:tokyonight_transparent = 1
let g:tokyonight_transparent_sidebar = 0
let g:tokyonight_italic_comments = 0
let g:tokyonight_italic_keywords = 0
let g:tokyonight_terminal_colors = 0
