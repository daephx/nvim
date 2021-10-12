" --- Statusline ---

" Ideally, I'd want multiple valid configurations for diffrent statuslines,
" and let the user choose which one should be loaded.

let s:statusline = 'lualine'

" --- Conditionals ---

if s:statusline == 'lualine'

  source $MYRUNTIME/lua/plugin/lualine.lua " lualine, status line
  set noshowmode " Don't show `--insert--` below statusline
  redraw | echom "Loaded: Lualine configuration"

elseif s:statusline == 'airline' && get(g:, 'loaded_airline', -1)

  source $MYRUNTIME/config/airline.vim " Airline, status line
  redraw | echom "Loaded: Airline configuration"

else
  echoerr "Error: No valid statusline (".s:statusline.") detected, reverting to default."
endif
