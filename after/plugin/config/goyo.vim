" Goyo | https://github.com/junegunn/goyo.vim
"
" Goyo is a vim plugin for distraction free writting,
" It gets a lot of the vim interface out of the way so you can focus!

" TODO(daephx): An issue I immediatly had was that, after toggling goyo off?
"               This attempts to reset your colorscheme, but it does not know about
"               any overrides you might have defined, such as `*bg=none` for transparency.

function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999

  Limelight

endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=5


  " FIXME(daephx): This is defined in multiple areas to overwrite the background
  "                and enable transparency within Vim itself.

  hi Comment      cterm=italic  gui=italic
  hi Comment                    guifg=gray
  hi CursorLineNr               guibg=none
  hi EndOfBuffer                guibg=none
  hi Folded                     guibg=none
  hi LineNr       ctermbg=none  guibg=none
  hi Normal       ctermbg=none  guibg=none
  hi SignColumn   ctermbg=none  guibg=none

  Limelight!

endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
