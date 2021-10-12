" --- Guard ---

if empty('g:dashbaord_version')
  finish
endif

" --- Functions ---

" Show image in dashboard using ansii escape sequences
" Usage: autocmd Filetype dashboard call DashboardImage()

function! DashboardImage()
  let s:width = 120
  let s:height = 17
  let s:row = float2nr(s:height / 5)
  let s:col = float2nr((&columns - s:width) / 2)
  let s:opts = {
    \ 'relative': 'editor',
    \ 'row': s:row,
    \ 'col': s:col,
    \ 'width': s:width,
    \ 'height': s:height,
    \ 'style': 'minimal'
    \ }
  let s:buf = nvim_create_buf(v:false, v:true)
  let s:win = nvim_open_win(s:buf, v:true, s:opts)
  hi! DashboardImage guibg=NONE guifg=NONE
  call nvim_win_set_option(s:win, "winblend", 0)
  call nvim_win_set_option(s:win, "winhl", "Normal:DashboardImage")
  terminal cat ~/Downloads/ascii.txt
  :exe "normal \<C-W>\<C-w>"
endfunction

" --- Bindings ---

" Dashboard provides session support.
nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>

" --- Settings ---

hi DashboardHeader ctermfg=Cyan

source $MYRUNTIME/lua/plugin/dashboard.lua
