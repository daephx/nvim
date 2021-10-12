" --- Git-Gutter ---

let g:gitgutter_enabled = 1

" disable plugin mappings
let g:gitgutter_map_keys = 0

let g:gitgutter_highlight_linenrs = 1

let g:gitgutter_override_sign_column_highlight = 1

nmap ) <Plug>(GitGutterNextHunk)
nmap ( <Plug>(GitGutterPrevHunk)

" highlight GitGutterAdd guifg=#009900 ctermfg=Green
" highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
" highlight GitGutterDelete guifg=#ff2222 ctermfg=Red

" Colors

highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" highlight DiffAdd guifg=#009900 guibg=none
" highlight DiffChange guifg=#bbbb00 guibg=none
" highlight DiffDelete guifg=#ff2222 guibg=none gui=none
"
" highlight clear SignColumn
" highlight GitGutterAdd ctermfg=2 guifg=#009900
" highlight GitGutterChange ctermfg=3 guifg=#bbbb00
" highlight GitGutterDelete ctermfg=1 guifg=#ff2222
" highlight GitGutterChangeDelete ctermfg=4 guifg=#ff0000
